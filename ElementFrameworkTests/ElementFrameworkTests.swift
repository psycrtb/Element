//
//  ElementFrameworkTests.swift
//  ElementFrameworkTests
//
//  Created by Tim B on 19.08.22.
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

    func testFireSameTime() {
        let currentTime = ConcreteTime(fromHHmmFormat: "00:00")!
        let cron = ConcreteCron(cronString: "0 0 abc")!
        
        let test = cron.nextFiring(basedOnTime: currentTime)
        
        XCTAssert(test.hour == 0 && test.minute == 0)
    }
    
    func testFireTomorrowDescription() {
        let currentTime = ConcreteTime(fromHHmmFormat: "00:01")!
        let cron = ConcreteCron(cronString: "0 0 abc")!
                
        let test = Scheduler.CronNextFiringDescription(basedOnTime: currentTime, forCron: cron)
        XCTAssert(test == "0:00 tomorrow - abc")
    }
    
    func testFireEveryMinDescription() {
        let currentTime = ConcreteTime(fromHHmmFormat: "00:59")!
        let cron = ConcreteCron(cronString: "* * abc")!
        
        let test = Scheduler.CronNextFiringDescription(basedOnTime: currentTime, forCron: cron)
        XCTAssert(test == "0:59 today - abc")
    }
    
    func testFireEveryHourDescription() {
        let currentTime = ConcreteTime(fromHHmmFormat: "00:59")!
        let cron = ConcreteCron(cronString: "1 * abc")!
        
        let test = Scheduler.CronNextFiringDescription(basedOnTime: currentTime, forCron: cron)
        XCTAssert(test == "1:01 today - abc")
    }
    
    func testFireSixtyMinDescription() {
        let currentTime = ConcreteTime(fromHHmmFormat: "00:59")!
        let cron = ConcreteCron(cronString: "* 0 abc")!
        
        let test = Scheduler.CronNextFiringDescription(basedOnTime: currentTime, forCron: cron)
        XCTAssert(test == "0:59 today - abc")
    }
    
    func testFireEndOfDayDescription() {
        let currentTime = ConcreteTime(fromHHmmFormat: "23:59")!
        let cron = ConcreteCron(cronString: "* * abc")!
        
        let test = Scheduler.CronNextFiringDescription(basedOnTime: currentTime, forCron: cron)
        XCTAssert(test == "23:59 today - abc")
    }
}
