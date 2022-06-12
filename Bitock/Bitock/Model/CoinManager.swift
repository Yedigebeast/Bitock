//
//  CoinManager.swift
//  Bitock
//
//  Created by Yedige Ashirbek on 11.06.2022.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdateCoin(_ coinManager:CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)

    
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "Put Your API Here!"
    var delegate: CoinManagerDelegate?
    let currencyArray = ["KZT", "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let cryptoList = ["BTC", "ETH", "USDT", "USDC", "BNB", "ADA", "XRP", "BUSD", "SOL", "DOGE", "DOT", "WBTC"]
    var currencySelected: String = "KZT"
    var cryptoSelected: String = "BTC"
    
    func getCoinPrice () {
        let urlString = "\(baseURL)/\(cryptoSelected)/\(currencySelected)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let price = decodedData.rate
            let currency = decodedData.asset_id_quote
            let crypto = decodedData.asset_id_base
            let coin: CoinModel = CoinModel(currency: currency, price: price, crypto: crypto)
            return coin
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
