require 'factory_bot_rails'

class Seeder
  def seed!
    truncate_tables
    create_users
    create_categories
    create_stores
    create_collections
    create_products
    load_videos
  end

  private

  def truncate_tables
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.tables.each do |table|
        next if %w(schema_migrations).include?(table)
        ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} CASCADE;")
      end
    end
  end

  def create_users
    puts 'SEEDING users'
    @user = FactoryBot.create(:admin_user, email: 'alex@loop.com', password: 'password')
    @user2 = FactoryBot.create(:admin_user, email: 'george@loop.com', password: 'password')
    @user3 = FactoryBot.create(:user)
  end

  def create_categories
    Settings.categories.each_pair do |parent_category_name, categories|
      puts parent_category_name

      parent_category = Category.where(name: parent_category_name).first_or_create

      categories.each_with_index do |category_name, index|
        puts category_name
        category = Category.where(name: category_name).first_or_create
        category.assign_attributes(
          parent_category: parent_category,
          sort_order: index
        )
        category.save!
      end
    end

    puts "#{Video.count} Videos"
  end

  def create_stores
    @store = Store.where(name: 'Amazon').first_or_create
    @website = Website.where(name: 'Youtube', domain: 'youtube.com').first_or_create
  end

  def create_collections
    ['latest', 'most liked', 'most viewed'].each do |name|
      FactoryBot.create(:online_video_collection, name: name)
    end

    homepage_collection = FactoryBot.create(
      :offline_collection_collection,
      name: 'homepage_collection'
    )

    Settings.categories.each_pair do |parent_category_name, _categories|
      puts parent_category_name

      collection = FactoryBot.create(
        :offline_video_collection,
        name: parent_category_name
      )

      CollectionCollection.create(
        collection: homepage_collection,
        children_collection: collection
      )
    end

    puts "#{homepage_collection.collections.size} Homepage Collection"

    associate_videos_with_categories_and_collections unless ENV['RAILS_ENV'] == 'production'
    puts "#{Video.count} Videos"
  end

  def create_products
    puts 'SEEDING products'

    Category.second_level.shuffle.each do |category|
      job = AmazonProductByCategoryETL.job(category, 1)
      Kiba.run(job)
      sleep 1
    end

    puts "#{ExternalProduct.count} External Products"
    puts "#{Product.count} Products"
  end

  def load_videos
    Importer::Youtube::Dispatcher.new.perform
    Transformer::Video.new.perform
  end

  # NON production
  def associate_videos_with_categories_and_collections
    Category.second_level.each do |category|
      videos = Video.where(category: category)
      videos.each do |video|
        video.tag_list.add(category.name)
        video.save
      end
    end

    Collection::Offline::Video.all.each do |collection|
      if category = Category.find_by_name(collection.name)
        collection.videos = Video.where(category: category.child_categories).limit(20)
      end
    end
  end

  def associate_products_with_videos
    products = Product.all
    Video.all.each_with_index do |video, index|
      FactoryBot.create(:video_product, video: video, product: products[4 * index])
      FactoryBot.create(:video_product, video: video, product: products[4 * index + 1])
      FactoryBot.create(:video_product, video: video, product: products[4 * index + 2])
      FactoryBot.create(:video_product, video: video, product: products[4 * index + 3])
    end
  end
end
