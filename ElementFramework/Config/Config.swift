//
//  Config.swift
//  Element
//
//  Created by Tim B on 12.08.22.
//

import Foundation

protocol Config {
    // Maybe i would do something nicer here. but im not sure what the format is gonna look like. so Array<String> it is
    func args() throws -> [String]
}
