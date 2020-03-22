require "rake"
require "fabrication"
require "faker"
require "rails-controller-testing"
require "database_cleaner"
require "devise"
# Loading more in this block will cause your tests to run faster. However,
# if you change any configuration or code from libraries loaded here, you'll
# need to restart spork for it take effect.

RAILS_ROOT = File.join(File.dirname(__FILE__), "../")
 
require "active_support"
require "active_model"
require "active_record"
require "action_controller"

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

::ActiveSupport::Deprecation.silenced = true

require File.expand_path(RAILS_ROOT + "/config/environment.rb")

ActiveRecord::Base.configurations = YAML::load(IO.read(RAILS_ROOT + "/config/database.yml"))
ActiveRecord::Base.establish_connection(ENV["DB"] || :test)
ActiveRecord::Migration.verbose = false

Rails.backtrace_cleaner.remove_silencers!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(RAILS_ROOT, "spec/support/**/*.rb")].each { |f| require f }

require "rspec/rails"

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.extend ControllerMacros, :type => :controller
  config.include Devise::Test::ControllerHelpers, type: :view
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Rails::Engine.subclasses.map(&:instance).map { |p| p.config.root.to_s }.each do |engine_dir|
  Dir.glob(File.join(engine_dir, "spec", "fabricators", "*")) { |file| require file } if File.directory? File.join(engine_dir, "spec", "fabricators")
end

require "simplecov"
SimpleCov.start "rails" do
  add_filter "spec/"
end

# Need to explictly load the files in lib/ until we figure out how to
# get rails to autoload them for spec like it used to...
Dir[File.join(RAILS_ROOT, "app/models/extensions/**/*.rb")].each { |f| load f }
