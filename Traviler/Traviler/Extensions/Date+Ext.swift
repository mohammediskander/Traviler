//
//  Date+Ext.swift
//  Todoiest
//
//  Created by Mohammed Iskandar on 08/12/2020.
//

import Foundation

extension Date {
        
    func to(format: String? = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)

    }
    
    func fromNow() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    static func getCurrent(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: Date())
    }
}
