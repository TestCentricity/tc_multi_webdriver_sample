# tc_multi_webdriver_sample

This is a Cucumber based sample test suite and framework utilizing the TestCentricity™ Web gem and a page-object model
architecture for desktop and mobile web functional testing using the Appium Pro Chat web portal. This example is intended
to demonstrate the instantiation of multiple WebDriver instances within a test case or test scenario to support the
verification of real-time multiple user interactions across multiple concurrent browsers.

Beginning with TestCentricity™ Web version 4.4.0, the `WebDriverConnect.initialize_web_driver` method accepts
an optional `options` hash for specifying desired capabilities (using the W3C protocol), driver type, driver name, endpoint
URL, device type, and desktop web browser window size information. TestCentricity also now supports the instantiation of
multiple WebDriver objects to establish connections with, and coordinate test execution between multiple desktop and/or
mobile web browser instances.

Some use cases for the verification of real-time multiple user interactions across multiple concurrent browsers or devices are:
- Chat, Messaging, or Social Media apps/web portals used by one or more users interacting in real time (posts, reposts, likes)
- Ride Hailing/Sharing Services with separate Rider and Driver experience apps/web portals
- Food Delivery Services with a Customer app for finding restaurants and ordering food, a Restaurant app for fulfilling
  the food order and coordinating delivery, and a Driver app for ensuring delivery of the order to the customer
- Learning Management/Student Engagement platforms that allow teachers to monitor student engagement and progress on assigned
  activities and support for remote real-time collaboration between students and teachers

This project was inspired by [**Edition 118 (Testing Real-Time User Interaction Using Multiple Simultaneous Appium Sessions)**](https://appiumpro.com/editions/118-testing-real-time-user-interaction-using-multiple-simultaneous-appium-sessions)
on the Appium Pro web site.


## Gem Dependencies:

cucumber  [![Gem Version](https://badge.fury.io/rb/cucumber.svg)](https://badge.fury.io/rb/cucumber)

testcentricity_web  [![Gem Version](https://badge.fury.io/rb/testcentricity_web.svg)](https://badge.fury.io/rb/testcentricity_web)


## Supporting Documentation

[TestCentricity Web Framework - testcentricity_web gem](https://rubygems.org/gems/testcentricity_web)

[TestCentricity Web - documentation](http://www.rubydoc.info/gems/testcentricity_web/)


## Prerequisites to running tests:

In order for Cucumber to execute the features and scenarios in the `tc_multi_webdriver_sample` test automation project
against desktop web browsers, you must have the Chrome, Firefox, and Edge desktop browsers installed on the test system
where the tests will be run.

The `tc_multi_webdriver_sample` test automation project also supports running tests against mobile web browsers running
on iOS simulators and Android virtual device emulators. The capabilities profiles for running tests against an iPhone,
iPad, Android phone, and an Android tablet are stored in the test data asset file located at `/config/test_data/data.yml`.

    📁 tc_multi_webdriver_sample
     ├── 📁 config
     │   └── 📁 test_data
     │       └── 📄 data.yml
     ├── 📁 doc
     ├── 📁 features
     └── 📁 reports

In order to run the tests against mobile web browsers, you must install Appium, XCode, the iOS version-specific device
simulators for XCode, Android Studio, and the desired Android version-specific virtual device emulators. The capabilities
profiles in `data.yml` file are currently set to the following:

| Mobile device browser | OS version ('appium:platformVersion':) | Device name ('appium:deviceName': / 'appium:avd':) |
|-----------------------|----------------------------------------|----------------------------------------------------|
| `:iPhone`             | '17.2'                                 | 'iPhone 13 Pro Max'                                |
| `:iPad`               | '17.2'                                 | 'iPad Pro (12.9-inch) (6th generation)'            |
| `:android_phone`      | '12.0'                                 | 'Pixel_5_API_31'                                   |
| `:android_tablet`     | '12.0'                                 | 'Pixel_C_API_31'                                   |

If you prefer to run tests against mobile web browsers using simulators other than the ones already preconfigured, you can
edit the capabilities profiles in the `data.yml` file. Refer to [**section 8.6 (Locally Hosted Mobile Browsers on Simulators or Physical Devices)**](https://www.rubydoc.info/gems/testcentricity_web#locally-hosted-mobile-browsers-on-simulators-or-physical-devices)
of the TestCentricity Web gem documentation for information on specifying the desired capabilities for mobile web simulators
and devices.


## Instructions for running tests

In order for Cucumber to execute features or scenarios from the `tc_multi_webdriver_sample` test automation project, the
`test_context` must be specified in the Cucumber command line at runtime. There are 3 test execution modes, or `test_context`,
that are supported:
  * `desktop`  - Desktop browsers only
  * `mobile`   - Mobile browsers only
  * `combined` - Combined desktop and mobile browsers

1. To run the Cucumber tests against desktop only web browsers, execute the following command in the Terminal:

        bundle exec cucumber -p test_context

   ℹ️ **NOTE:**
    * To have Cucumber generate HTML formatted test results, append `-p report` to the above command line arguments.

   For example, to execute the test suite against desktop only web browsers, with test results being logged to an HTML test
   results file, execute the following command in the Terminal:

        bundle exec cucumber -p desktop -p report

   To execute the test suite against mobile only web browsers, execute the following command in the Terminal:

        bundle exec cucumber -p mobile

   To execute the test suite against desktop and mobile web browsers, execute the following command in the Terminal:

        bundle exec cucumber -p combined

   ℹ️ **NOTE:**
    * Appium will automatically be started prior to tests being executed against mobile browser (`mobile` and `combined`
      test contexts)

2. As the Cucumber tests are executing, the Terminal will display the lines of each feature file and scenario as they run
   in real-time.

3. Upon completion of test execution, the Terminal will display the final test results.

4. If you specified in the command line that HTML formatted test results should be generated (`-p report`), you can view 
   them by opening the `reports` folder in the `tc_multi_webdriver_sample` project directory, and selecting the `test_results.html`
   file. Right-clicking on the `test_results.html` file will display a popup menu. Select the **Open in Browser** menu
   item, and then select a web browser from the popup sub menu that appears. The formatted test results will open in the
   web browser that you selected.


## Detailed Documentation

Detailed HTML documentation of the features, scenarios, step definitions, classes, and methods for the `tc_multi_webdriver_example`
project can be accessed from the `index.html` file within the `doc` folder in the `tc_multi_webdriver_example` project folder:

    📁 tc_multi_webdriver_sample
     ├── 📁 config
     ├── 📁 doc
     │   └── 📄 index.html
     ├── 📁 features
     └── 📁 reports

To view this documentation, navigate to the `index.html` file, right click on it, and select *Open in Browser*
