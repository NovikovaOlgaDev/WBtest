//
//  DateFormatterManager.swift
//  WBtravel
//
//  Created by Olga on 13.08.2023.
//

import Foundation

class DateFormatterManager { // https://nsdateformatter.com
    
    static let shared = DateFormatterManager()
    
    let dateFormatter = DateFormatter()
    
    func dateFormatterStringToDate(from dateString: String) -> Date {
       
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss ZZZZ zzz"
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError()
        }
        return date
    }
    
    func dateFormatterDateToString(from dateDate: Date, format: String) -> String {
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = format //"dd-MM-yyyy hh : mm"
        let date = dateFormatter.string(from: dateDate)
        return date
    }
}
