
def run_first_once
  # HTML report header information if reporting is enabled
  log Environ.report_header if ENV['REPORTING']
end


BeforeAll do
  $feature = nil
  $users = []
  # create Cucumber reports folder if it doesn't already exist
  if ENV['REPORTING']
    reports_path = "#{Dir.pwd}/reports"
    Dir.mkdir(reports_path) unless Dir.exist?(reports_path)
  end
  # start Appium Server if command line option was specified
  if ENV['APPIUM_SERVER'] == 'run'
    $server = TestCentricity::AppiumServer.new
    $server.start
  end
end


AfterAll do
  # close driver
  WebDriverConnect.close_all_drivers
  # terminate Appium Server if command line option was specified and target browser is mobile simulator or device
  if ENV['APPIUM_SERVER'] == 'run' && $server.running?
    $server.stop
  end
end


Before do |scenario|
  # if executing tests in parallel concurrent threads, print thread number with scenario name
  message = Environ.parallel ? "Thread ##{Environ.process_num} | Scenario:  #{scenario.name}" : "Scenario:  #{scenario.name}"
  log message
  $initialized ||= false
  unless $initialized
    $initialized = true
    $test_start_time = Time.now
    # if a run first/run once method is defined, call it
    run_first_once if defined? run_first_once
  end
  # close all webdrivers when starting tests on a different cuke feature file
  current_feature_file = scenario.location.to_s.split(':')[0]
  if $feature != current_feature_file
    $feature = current_feature_file
    WebDriverConnect.close_all_drivers
    $users = []
  end
end


After do |scenario|
  # save the feature file location for tracking when all scenarios have been executed in a feature file
  $feature = scenario.location.to_s.split(':')[0]
  # process and embed any screenshots recorded during execution of scenario
  process_embed_screenshots(scenario)
  # clear out any queued screenshots
  Environ.reset_contexts
  # block any JavaScript modals that may appear as a result of ending the session
  Browsers.suppress_js_leave_page_modal
end


def screen_shot_and_save_page(scenario)
  timestamp = Time.now.strftime('%Y%m%d%H%M%S%L')
  filename = scenario.nil? ? "Screenshot-#{timestamp}.png" : "Screenshot-#{scenario.__id__}-#{timestamp}.png"
  path = File.join Dir.pwd, 'reports/screenshots/', filename
  save_screenshot path
  log "Screenshot saved at #{path}"
  screen_shot = { path: path, filename: filename }
  Environ.save_screen_shot(screen_shot)
  attach(path, 'image/png') unless scenario.nil?
end

def process_embed_screenshots(scenario)
  screen_shots = Environ.get_screen_shots
  if screen_shots.count > 0
    screen_shots.each do |row|
      path = row[:path]
      attach(path, 'image/png')
    end
  else
    screen_shot_and_save_page(scenario) if scenario.failed?
  end
end
