//
//  DisplayTimeViewController.swift
//  Fruit
//
//  Created by George McDonnell on 20/04/2017.
//  Copyright © 2017 George McDonnell. All rights reserved.
//

import UIKit

/**
 Tracks the display duration and updates the stats
 */
class DisplayTimeViewController: UIViewController {

    /** A timestamp of the current date and time */
    private var timestamp: Date?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timestamp = Date()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let currentTimestamp = timestamp {
            let displayTime = Int(Date().timeIntervalSince(currentTimestamp) * 1000)
            API.instance.updateDisplayStats(displayTime: String(displayTime))
        }
    }
}
