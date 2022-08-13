//
//  Scheduler.swift
//  ElementFramework
//
//  Created by Tim B on 12.08.22.
//

import Foundation


public enum SchedulerError: Error {
    case noSchedule
    case cantReadCurrentTime
    case scheduleCorrupted
}

public class Scheduler {
    private let location: String
    private let currentTime: String
    
    public init(location: String, currentTime: String) {
        self.location = location
        self.currentTime = currentTime
    }
    
    public func runSchedule() throws {
        do {
            let rawCrons = try TextFileConfig(location: location)
            
            for cronString in rawCrons.args() {
                
                let cronStringSeparated = cronString.split(separator: " ")
                if cronStringSeparated.count == 3 {
                    let minute = String(cronStringSeparated[0])
                    let hour = String(cronStringSeparated[1])
                    let command = String(cronStringSeparated[2])
                    
                    if let cron: Cron = ConcreteCron(minute: minute, hour: hour, command: command) {
                        guard let current = Time(fromHHmmFormat: currentTime) else {
                            // We throw an error because current time couldnt be parsed
                            throw SchedulerError.cantReadCurrentTime
                        }
                        
                        print(cron.nextFiringStatement(currentTime: current))
                    }
                } else {
                    throw SchedulerError.scheduleCorrupted
                }
            }
            
        }
    }
}
