//
//  main.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation
import ElementFramework


var stdin: Data
stdin = FileHandle.standardInput.availableData

let str = String(data: stdin, encoding: .ascii)
//let str = TestData.CronsString

let commandArgTime = CommandLine.arguments[1]
let currentTime = Scheduler.CreateTime(fromHHmmFormat: commandArgTime)

// Parse
if let split = str?.components(separatedBy: "\n") {

    var crons: [Cron] = []
    for cronString in split {
        if let cron = Scheduler.CreateCron(cronString: cronString) {
            crons.append(cron)
        }
    }
    
    for cron in crons {
        if let currentTime = currentTime {
            let scheduledCronFiringDescription = Scheduler.CronNextFiringDescription(basedOnTime: currentTime, forCron: cron)
            print(scheduledCronFiringDescription)

        }
    }
}
