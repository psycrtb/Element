//
//  main.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation
import ElementFramework

let stdin = CommandLine.arguments[0]
print("Location:", stdin) // So i can get access to it easier and test in terminal


let args = CommandLine.arguments.dropFirst()
print("Number of arguments:", args.count)

print("Arguments:")
for arg in args {
    print("-", arg)
}

// Classes below
let file = CommandLine.arguments[1]
let currentTime = CommandLine.arguments[2]


// We keep the code in a framework. Because we want it to use XCTest and a command line project alone cannot use XCTest.
// Im very used to using frameworks in applications so this didnt take long but the structure leaves me to be a little unhappy with it
// But its a very quick implementation so dont expect the interface to be nice
do {
    let scheduler = Scheduler(location: file, currentTime: currentTime)
    try scheduler.runSchedule()
} catch SchedulerError.noSchedule {
    print("No schedule given")
} catch SchedulerError.cantReadCurrentTime {
    print("Can't read current time")
} catch SchedulerError.scheduleCorrupted {
    print("Test file has an error")
}
