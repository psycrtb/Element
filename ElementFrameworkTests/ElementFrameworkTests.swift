//
//  ElementFrameworkTests.swift
//  ElementFrameworkTests
//
//  Created by Tim B on 12.08.22.
//

import XCTest
@testable import ElementFramework

class ElementFrameworkTests: XCTestCase {

    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 2 simple framework tests to make sure they warn the user
    
    func testSchedulerBadLocation() {
        do {
            let scheduler = Scheduler(location: "fail", currentTime: "12:34")
            try scheduler.runSchedule() // Throw a no schedule error
            
            XCTFail()
        } catch let error {
            let err = error as? SchedulerError
            XCTAssert(err == SchedulerError.noSchedule)
        }
    }
    
    func testSchedulerBadTime() {
        do {
            if let test1 = Bundle.main.url(forResource: "test1", withExtension: "txt", subdirectory: "Test") {
                let scheduler = Scheduler(location: test1.absoluteString, currentTime: "ab:34")
                try scheduler.runSchedule() // Throw a no cant read time error
                
                XCTFail()
            }
        } catch let error {
            let err = error as? SchedulerError
            XCTAssert(err == SchedulerError.cantReadCurrentTime)
        }
    }

    // Tests a result that will fire soon
    func testGoodResultOneMinuteInFuture() {
        let cron = ConcreteCron(minute: "12", hour: "12", command: "hello")
        let nextStatement = cron?.nextFiringStatement(currentTime: Time(hour: 12, minute: 11))
        XCTAssert(nextStatement == "12:12 today - hello")
    }
    
    // Tests a result that will fire soon
    func testGoodResultTomorrow() {
        let cron = ConcreteCron(minute: "59", hour: "23", command: "bin/command")
        let nextStatement = cron?.nextFiringStatement(currentTime: Time(hour: 23, minute: 59))
        XCTAssert(nextStatement == "23:59 tomorrow - bin/command")
    }
    
    func testGoodResultEveryMin() {
        let cron = ConcreteCron(minute: "*", hour: "*", command: "bin/command")
        let nextStatement = cron?.nextFiringStatement(currentTime: Time(hour: 23, minute: 59))
        XCTAssert(nextStatement == "00:00 tomorrow - bin/command")
    }
    
    func testGoodResultEveryHour() {
        let cron = ConcreteCron(minute: "12", hour: "*", command: "bin/command")
        let nextStatement = cron?.nextFiringStatement(currentTime: Time(hour: 23, minute: 59))
        XCTAssert(nextStatement == "00:12 tomorrow - bin/command")
    }
    
    func testGoodResultHour60Times() {
        let cron = ConcreteCron(minute: "*", hour: "15", command: "bin/command")
        let nextStatement = cron?.nextFiringStatement(currentTime: Time(hour: 23, minute: 59))
        XCTAssert(nextStatement == "15:00 tomorrow - bin/command")
    }
}

