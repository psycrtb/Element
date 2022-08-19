//
//  TestHandler.swift
//  ElementFrameworkTests
//
//  Created by Tim B on 19.08.22.
//

import Foundation

public struct TestData {
    public static var CronsString: String? = {
        let dataString = "30 1 /bin/run_me_daily\n45 * /bin/run_me_hourly\n* * /bin/run_me_every_minute\n* 19 /bin/run_me_sixty_times"
        return dataString
    }()
}
