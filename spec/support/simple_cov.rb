require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/vendor/'

  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views'
  add_group 'Controllers', 'app/controllers'

  add_group 'Services', 'app/services'

  add_group 'Libraries', 'lib'

  add_group 'Long files' do |src_file|
    src_file.lines.count > 100
  end
end
