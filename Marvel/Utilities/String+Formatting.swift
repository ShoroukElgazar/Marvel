//
//  Date+DateFormat.swift
//  Marvel
//
//  Created by Mac on 18/06/2023.
//

import Foundation

extension String {
    func convertToFormattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: self) {
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "dd/MM/YYYY"
            return newDateFormatter.string(from: date)
        }
        return ""
    }
}
