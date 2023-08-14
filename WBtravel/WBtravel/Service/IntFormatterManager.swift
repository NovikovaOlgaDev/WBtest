//
//  IntFormatterManager.swift
//  WBtravel
//
//  Created by Olga on 13.08.2023.
//

import Foundation

class IntFormatterManager {
    
    static let shared = IntFormatterManager()
    
    func intFotmatterForPrice(from price: Int) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.maximumFractionDigits = 0
        
        let str = numberFormatter.string(for: price) ?? ""
 
        return str

    }
}
