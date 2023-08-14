//
//  Flight.swift
//  WBtravel
//
//  Created by Olga on 13.08.2023.
//

import Foundation

struct Flights {
    let searchToken: String
    let startCity: String
    let endCity: String
    let price: Int
    let startDate: Date
    let endDate: Date
    let startIATA: String
    let endIATA: String
    var likeStatus: Bool
}
