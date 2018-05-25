Finder::Base = Struct.new(:params) do
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 20
  DEFAULT_SORT_COLUMN = 'id'.freeze
  DEFAULT_SORT_DIRECTION = 'ASC'.freeze
  VALID_SORT_DIRECTIONS = %w(ASC DESC).freeze

  include HasScope

  class_attribute :table_columns, :default_include_tables,\
                  :collection_decorator_const, :class_const,\
                  :default_additional_scopes, :default_per_page,\
                  :default_sort_column, :default_sort_direction

  attr_accessor :scope

  self.collection_decorator_const = PaginationDecorator
  self.default_additional_scopes = []
  self.default_include_tables = []

  def find
    search_scope.ransack(params[:q]).result(distinct: true)
  end

  def page
    @page ||= params[:page] || DEFAULT_PAGE
  end

  def per_page
    @per_page ||= params[:per_page] || default_per_page || DEFAULT_PER_PAGE
  end

  private

  def search_scope
    @search_scope ||= begin
      select_columns
      include_tables
      filter_by_scope
      order_by
      paginate
    end
  end

  def select_columns
    @scope = class_const.select(table_columns)
  end

  def include_tables
    @scope = @scope.includes(default_include_tables + (params[:additional_tables] || []))
  end

  def filter_by_scope
    additional_scopes.each do |scope|
      @scope = @scope.send(scope)
    end
    @scope = apply_scopes(@scope)
  end

  def additional_scopes
    @addl_scopes ||= params[:additional_scopes] || default_additional_scopes
  end

  # order by
  def order_by
    order_bys = params[:order_bys] || ["#{sort_column} #{sort_direction}"]
    @scope = @scope.order(order_bys.join(', '))
  end

  def sort_column
    @sort_column ||= params[:sort_column] || default_sort_column || DEFAULT_SORT_COLUMN
  end

  def sort_direction
    @sort_direction ||= VALID_SORT_DIRECTIONS.include?(params[:sort_direction]) && params[:sort_direction] \
      || default_sort_direction \
      || DEFAULT_SORT_DIRECTION
  end

  # paginate
  def paginate
    @scope = @scope.page(page).per(per_page)
  end
end
