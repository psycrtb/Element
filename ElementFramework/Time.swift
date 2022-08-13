//
//  Time.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation

struct Time {
    private var _hour: Int = 0
    private var _minute: Int = 0

    var hour: Int {
        set {
            if newValue >= 24 {
                _hour = 0
            } else if newValue < 0 {
                _hour = 0
            } else {
                _hour = newValue
            }
        }
        get { return _hour }
    }
    
    var minute: Int {
        set {
            if newValue >= 60 {
                _minute = 0
                hour = hour + 1
            } else if newValue < 0 {
                _minute = 0
            } else {
                _minute = newValue
            }
        }
        get { return _minute }
    }
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    // Build a time object from the HH:mm format that is failable if format isnt perfect. This needs more error catching though.
    init?(fromHHmmFormat format: String) {
        let hhmm = format.split(separator: ":")
        if let initHour = Int(hhmm.first ?? "") {
            self.hour = initHour
        }
        if let initMinute = Int(hhmm.last ?? "") {
            self.minute = initMinute
        }
    }

    var description: String {
        var hourStr = "\(self.hour)"
        if self.hour < 10 {
            hourStr = "0\(self.hour)"
        }
        var minStr = "\(self.minute)"
        if self.minute < 10 {
            minStr = "0\(self.minute)"
        }
        return "\(hourStr):\(minStr)"
    }
}

/** Add comparable to the time object*/
extension Time: Comparable {
    static func < (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour < rhs.hour {
            return true
        } else if lhs.hour == rhs.hour {
            if lhs.minute < rhs.minute {
                return true
            }
        }
        return false
    }

    static func <= (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour <= rhs.hour {
            if lhs.minute <= rhs.minute {
                return true
            }
        }
        return false
    }
    
    static func > (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour > rhs.hour {
            return true
        } else if lhs.hour == rhs.hour {
            if lhs.minute > rhs.minute {
                return true
            }
        }
        return false
    }
    
    static func >= (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour >= rhs.hour {
            if lhs.minute >= rhs.minute {
                return true
            }
        }
        return false
    }
    
    static func == (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour == rhs.hour && lhs.minute == rhs.minute {
            return true
        }
        return false
    }
    
    static func != (lhs: Time, rhs: Time) -> Bool {
        return !(lhs == rhs)
    }
}
