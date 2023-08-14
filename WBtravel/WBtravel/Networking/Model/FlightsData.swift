//
//  FlightsData.swift
//  WBtravel
//
//  Created by Olga on 13.08.2023.
//

import Foundation

struct FlightsData: Codable {
    let flights: [Flight]
}

struct Flight: Codable { 
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let price: Int
    let searchToken: String
}
