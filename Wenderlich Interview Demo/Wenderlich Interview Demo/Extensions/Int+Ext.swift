//
//  Int+Ext.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 2/3/22.
//

import Foundation

extension Int {
    func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int, leftMinutes: Int) {
        var minutes = minutes / 60
        
        let hours = minutes / 60
        minutes = minutes % 60
        
        return (hours, minutes)
    }
}
