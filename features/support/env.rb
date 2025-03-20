require 'capybara/cucumber'
require 'testcentricity_web'
require 'parallel_tests'
require 'require_all'
require 'pry'

require_relative 'world_data'
require_relative 'world_pages'

require_rel 'data'
require_rel 'pages'

# set Capybara's default max wait time to 20 seconds
Capybara.default_max_wait_time = 20

# set the default locale and auto load all translations from config/locales/*.rb,yml.
ENV['LOCALE'] = 'en-US' unless ENV['LOCALE']
I18n.load_path += Dir['config/locales/*.{rb,yml}']
I18n.default_locale = ENV['LOCALE']
I18n.locale = ENV['LOCALE']
Faker::Config.locale = ENV['LOCALE']

# instantiate all data objects and target test environment
include WorldData
environs.find_environ(ENV['TEST_ENVIRONMENT'])
WorldData.instantiate_data_objects

# instantiate all page objects
include WorldPages
WorldPages.instantiate_page_objects

# suppress Capybara warnings for :clear_local_storage and :clear_session_storage
Selenium::WebDriver.logger.ignore(:clear_local_storage, :clear_session_storage)
