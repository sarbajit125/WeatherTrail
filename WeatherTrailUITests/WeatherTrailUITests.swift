//
//  WeatherTrailUITests.swift
//  WeatherTrailUITests
//
//  Created by comviva on 20/02/22.
//

import XCTest

class WeatherTrailUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

//        app/*@START_MENU_TOKEN@*/.staticTexts["CONTINUE"]/*[[".buttons[\"CONTINUE\"].staticTexts[\"CONTINUE\"]",".staticTexts[\"CONTINUE\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Hourly"]/*[[".segmentedControls.buttons[\"Hourly\"]",".buttons[\"Hourly\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Select Temperature Unit"]/*[[".buttons[\"Select Temperature Unit\"].staticTexts[\"Select Temperature Unit\"]",".staticTexts[\"Select Temperature Unit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Celsius"]/*[[".cells.buttons[\"Celsius\"]",".buttons[\"Celsius\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.pickerWheels["Bangalore"]/*[[".pickers.pickerWheels[\"Bangalore\"]",".pickerWheels[\"Bangalore\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.textFields["Enter City Name"].tap()
//        app.buttons["Check"].tap()
        
        let continueBtn = app.staticTexts["CONTINUE"]
        XCTAssertTrue(continueBtn.isEnabled, "Continue Button is not enabled for user interaction")
        continueBtn.tap()
        let hourlyBtn = app.buttons["Hourly"]
        XCTAssertTrue(hourlyBtn.isEnabled, "Hourly Button is not enabled for user interaction")
        let selectUnit = app.staticTexts["Select Temperature Unit"]
        XCTAssertTrue(selectUnit.isEnabled, "Select Temperature Unit is not enabled for user interaction")
        selectUnit.tap()
        let celsiusBtn = app.collectionViews.buttons["Celsius"]
        XCTAssertTrue(celsiusBtn.isEnabled, "Celsius Button is not enabled for user interaction")
        let cityPicker = app.pickerWheels["Bangalore"]
        XCTAssertTrue(cityPicker.isEnabled,"City Picker is not enabled for user interaction")
        let enterCity = app.textFields["Enter City Name"]
        XCTAssertTrue(enterCity.isEnabled, "Enter City Name is not enabled for user interaction")
//        let checkBtn = app.buttons["Check"]
//        XCTAssertTrue(checkBtn.isEnabled, "Check Button is not enabled for user interaction")
        
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
