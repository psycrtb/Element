//
//  TextFileInput.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation

class TextFileConfig: Config {
    let unformattedContents: String
    
    init(location: String) throws {
        
        do {
            let contents = try String(contentsOfFile: location)
            print(contents)
            unformattedContents = contents
            
        } catch {
            throw SchedulerError.noSchedule
            // I would do some nicer error handling here. I think for this test its acceptable to just throw here
        }
    }
    
    // its probably acceptable to deal with strings here
    func args() ->  [String] {
        let separated = unformattedContents.split(separator: "\n")
        let formattedAndSeparated = separated.map({ String($0) })
        return formattedAndSeparated
    }
}
