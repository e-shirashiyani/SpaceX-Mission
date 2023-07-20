//
//  DateTimeConverter.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/20/23.
//

import Foundation

class DateTimeConverter {
    static func convertUTCToLocal(dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let utcDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Customize the date format as needed
        
        return dateFormatter.string(from: utcDate)
    }
}
