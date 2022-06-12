//
//  CoinModel.swift
//  Bitock
//
//  Created by Yedige Ashirbek on 12.06.2022.
//

import Foundation

struct CoinModel {
    
    let currency: String
    let price: Double
    let crypto: String
    
    var priceString: String {
         
            return String(format: "%.5f", price)
            
        }
    
}
