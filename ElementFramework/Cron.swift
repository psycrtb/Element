//
//  Cron.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation

// enum specifies when the cron can run.
enum RunOn {
    case everyMinute            // * *
    case everyMinuteOnHour(Int) // * x
    case everyHourAt(Int)       // x *
    case everyDayAt(Int, Int)   // x x
}

protocol Cron {
    func nextFiringStatement(currentTime: Time) -> String
}

class ConcreteCron: Cron {
    
    private let run: RunOn
    let command: String
    
    init?(minute: String, hour: String, command: String) {
        
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
            print("everyday \(intHour) \(intMin)")
            run = .everyDayAt(intHour, intMin)
        }
        
        self.command = command
    }
    
    private func nextFiringTime(currentTime: Time) -> Time {
        switch run {
        case .everyMinute:
            return Time(hour: currentTime.hour, minute: currentTime.minute + 1)
        case .everyMinuteOnHour(let hour):
//            if the current hour is the same as the firing hour
            if currentTime.hour == hour {
                return Time(hour: currentTime.hour, minute: currentTime.minute + 1)
            }
            return Time(hour: hour, minute: 0)
        case .everyHourAt(let minute):
//            if the firing minute is passed or equal to current minute increment hour
            if currentTime.minute >= minute {
                return Time(hour: currentTime.hour + 1, minute: minute)
            }
            return Time(hour: currentTime.hour, minute: minute)
        case .everyDayAt(let hour, let minute):
            print("\(minute)  ... h \(hour)")
            return Time(hour: hour, minute: minute)
        }
    }
    
    func nextFiringStatement(currentTime: Time) -> String {
        let nextFiring = nextFiringTime(currentTime: currentTime)

        var day = "today"
        if currentTime >= nextFiring {
            day = "tomorrow"
        }
        
        return "\(nextFiring.description) \(day) - \(command)"
    }
}
