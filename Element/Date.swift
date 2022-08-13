//
//  Date.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation

// NOTE: I was going to use date... but i wasnt sure if it was included in the 'existing libraries' clause. so i ended up doing it programatically. I did write this and then realised its probably a library.
// I will leave it here because i was going to use it and thought you might want to see my original direction.
extension Date {
    
    // We switch the input string into swift.date because it will do all the work for me
    // Remember this is UTC - it confused me for about 2 minutes
    static func date(fromHHmmString hhmmString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: hhmmString)
        return date
    }

}
