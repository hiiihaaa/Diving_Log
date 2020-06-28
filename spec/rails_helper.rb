ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__) # このソースファイルと同ディレクトリにあるenvironment.rbをrequire?

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_bot'
require 'devise'
require 'faker'
# require 'capybara/rspec'


begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

  config.include FactoryBot::Syntax::Methods
  # config.include ControllerMacros, type: :controller
  # config.include Devise::Test::ControllerHelpers, type: :controller
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

end
