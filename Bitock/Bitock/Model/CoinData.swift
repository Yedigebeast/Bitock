//
//  CoinData.swift
//  Bitock
//
//  Created by Yedige Ashirbek on 12.06.2022.
//

import Foundation

struct CoinData: Decodable {
    
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
}
