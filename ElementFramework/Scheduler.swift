//
//  Scheduler.swift
//  ElementFramework
//
//  Created by Tim B on 12.08.22.
//

import Foundation

public class Scheduler {
    public static func CreateCron(cronString: String) -> Cron? {
        return ConcreteCron(cronString: cronString)
    }
    
    public static func CreateTime(fromHHmmFormat timeString: String) -> Time? {
        return ConcreteTime(fromHHmmFormat: timeString)
    }
    
    public static func CronNextFiringDescription(basedOnTime currentTime: Time, forCron cron: Cron) -> String {
        let nextFire = cron.nextFiring(basedOnTime: currentTime)

        var day = "today"
        if currentTime.greaterThan(comparison: nextFire) {
            day = "tomorrow"
        }
        
        return "\(nextFire.description) \(day) - \(cron.command)"
    }
}
