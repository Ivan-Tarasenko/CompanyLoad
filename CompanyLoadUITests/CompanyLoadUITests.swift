//
//  CompanyLoadUITests.swift
//  CompanyLoadUITests
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import XCTest

final class CompanyLoadUITests: XCTestCase {
    let accessibility = AccessibilityIdentifier()
    var app: XCUIApplication!
    
    // Cell
    var cell: XCUIElement!
    var titleLabel: XCUIElement!
    var imageCard: XCUIElement!
    var topSeparator: XCUIElement!
    var scoreLabel: XCUIElement!
    var cashbackLabel: XCUIElement!
    var percentCachbackLabel: XCUIElement!
    var levelLabel: XCUIElement!
    var disriptionLevelLabel: XCUIElement!
    var bottomSeparator: XCUIElement!
    var hideCardButton: XCUIElement!
    var trashCardButton: XCUIElement!
    var detailCardButton: XCUIElement!
    
    // Controller
    var cardManagementButton: XCUIElement!
    var tableView: XCUIElement!
    
    // Preloader
    var spinning: XCUIElement!
    var textLabel: XCUIElement!
    
    var alertError: XCUIElement!
    var hideButtonAlert: XCUIElement!
    var trashButtonAlert: XCUIElement!
    var detailButtonAlert: XCUIElement!
    var managementButtonAlert: XCUIElement!
    var buttonAlert: XCUIElement!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        // Cell
        cell = app.cells.element(boundBy: 0)
        titleLabel = app.staticTexts[accessibility.titleLabel]
        imageCard = app.images[accessibility.imageCard]
        topSeparator = app.otherElements[accessibility.topSeparator]
        scoreLabel = app.staticTexts[accessibility.scoreLabel]
        cashbackLabel = app.staticTexts[accessibility.cashbackLabel]
        percentCachbackLabel = app.staticTexts[accessibility.percentCachbackLabel]
        levelLabel = app.staticTexts[accessibility.levelLabel]
        disriptionLevelLabel = app.staticTexts[accessibility.disriptionLevelLabel]
        bottomSeparator = app.otherElements[accessibility.topSeparator]
        hideCardButton = cell.buttons[accessibility.hideCardButton]
        trashCardButton = cell.buttons[accessibility.trashCardButton]
        detailCardButton = cell.buttons[accessibility.detailCardButton]
        
        // Controller
        cardManagementButton = app.buttons[accessibility.cardManagementButton]
        tableView = app.tables[accessibility.tableView]
        
        // Preloader
        spinning = app.otherElements[accessibility.topSeparator]
        textLabel = app.staticTexts[accessibility.textLabel]
        
        alertError = app.alerts[accessibility.alertError]
        hideButtonAlert = app.alerts[accessibility.hideButtonAlert]
        trashButtonAlert = app.alerts[accessibility.trashButtonAlert]
        detailButtonAlert = app.alerts[accessibility.detailButtonAlert]
        managementButtonAlert = app.alerts[accessibility.managementButtonAlert]
        buttonAlert = app.alerts.buttons[accessibility.buttonAlert]
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testForPresenceOfElements() throws {
        sleep(3)
        
        if !alertError.exists {
            XCTAssert(tableView.exists)
            XCTAssert(cell.exists)
            XCTAssertTrue(titleLabel.exists)
            XCTAssertTrue(imageCard.exists)
            XCTAssertTrue(topSeparator.exists)
            XCTAssertTrue(scoreLabel.exists)
            XCTAssertTrue(cashbackLabel.exists)
            XCTAssertTrue(percentCachbackLabel.exists)
            XCTAssertTrue(levelLabel.exists)
            XCTAssertTrue(disriptionLevelLabel.exists)
            XCTAssertTrue(bottomSeparator.exists)
            XCTAssertTrue(hideCardButton.exists)
            XCTAssertTrue(trashCardButton.exists)
            XCTAssertTrue(detailCardButton.exists)
            
            XCTAssertTrue(cardManagementButton.exists)
            
            XCTAssertTrue(spinning.exists)
            XCTAssert(textLabel.exists)
            
        } else {
            
            XCTAssertTrue(alertError.exists)
            
        }
        
    }
    
    func testOfAddingCells() throws {
        
        var numberOfCells = 5
        
        for _ in 1...3 {
            if !alertError.exists {
                sleep(3)
                print(numberOfCells)
                XCTAssertEqual(tableView.cells.count, numberOfCells)
                app.swipeUp()
                app.swipeUp()
                numberOfCells += 5
            } else {
                XCTAssertTrue(alertError.exists)
                buttonAlert.tap()
                break
            }
        }
    }
    
    func testTapButton() throws {
        sleep(3)
        
        if !alertError.exists {
            hideCardButton.tap()
            XCTAssertTrue(hideButtonAlert.exists)
            buttonAlert.tap()
            
            trashCardButton.tap()
            XCTAssertTrue(trashButtonAlert.exists)
            buttonAlert.tap()
            
            detailCardButton.tap()
            XCTAssertTrue(detailButtonAlert.exists)
            buttonAlert.tap()
            
            cardManagementButton.tap()
            XCTAssertTrue(managementButtonAlert.exists)
            buttonAlert.tap()
            
        } else {
            XCTAssertTrue(alertError.exists)
            buttonAlert.tap()
        }
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
