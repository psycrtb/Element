//
//  Cron.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation

public protocol Cron {
    var command: String { get }
    
    func nextFiring(basedOnTime: Time) -> Time
    
    init?(cronString: String)
}

// enum specifies when the cron can run.
enum RunOn {
    case everyMinute            // * *
    case everyMinuteOnHour(Int) // * x
    case everyHourAt(Int)       // x *
    case everyDayAt(Int, Int)   // x x
}

class ConcreteCron: Cron {
    
    private let run: RunOn
    let command: String
    
    required init?(cronString: String) {
        let split = cronString.components(separatedBy: " ")
        guard split.count == 3 else {
            return nil
        }
        let minute = split[0]
        let hour = split[1]
        let command = split[2]
        
        // We will set everyMin/Hour if a * comes through for that. otherwise we use intMin/Hour.
        var everyMin = false
        var everyHour = false
        var intMin = -1         // If these are -1 at the end. it implies
        var intHour = -1
    
        if minute == "*" {
            everyMin = true
        } else if let tempMin = Int(minute) {
            intMin = tempMin
            if intMin == -1 { // We failed to parse and should quit
                return nil
            }
        }

        
        if hour == "*" {
            everyHour = true
        } else if let tempHour = Int(hour) {
            intHour = tempHour
            if intHour == -1 { // We failed to parse and should quit
                return nil
            }
        }
        
        // We check if there is any *'s and we run as everyMin/hour
        if everyMin && everyHour {
            run = .everyMinute
        } else if everyMin {
            run = .everyMinuteOnHour(intHour)
        } else if everyHour {
            run = .everyHourAt(intMin)
        } else {
            run = .everyDayAt(intHour, intMin)
        }
        
        self.command = command
    }
    
    // Does this violate single responsibility?
    func nextFiring(basedOnTime passedInTime: Time) -> Time {
        switch run {
        case .everyMinute:
            return ConcreteTime(hour: passedInTime.hour, minute: passedInTime.minute)
        case .everyMinuteOnHour(let hour):
            // if the current hour is the same as the firing hour
            if passedInTime.hour == hour {
                return ConcreteTime(hour: passedInTime.hour, minute: passedInTime.minute)
            }
            return ConcreteTime(hour: hour, minute: 0)
        case .everyHourAt(let minute):
            // if the firing minute is passed or equal to current minute increment hour
            if passedInTime.minute > minute {
                return ConcreteTime(hour: passedInTime.hour + 1, minute: minute)
            }
            return ConcreteTime(hour: passedInTime.hour, minute: minute)
        case .everyDayAt(let hour, let minute):
            return ConcreteTime(hour: hour, minute: minute)
        }
    }
    
}
