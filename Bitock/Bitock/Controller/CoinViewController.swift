//
//  ViewController.swift
//  Bitock
//
//  Created by Yedige Ashirbek on 11.06.2022.
//

import UIKit

class CoinViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    
    @IBOutlet weak var cryptoImage: UIImageView!
    @IBOutlet weak var bitcoinCost: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CurrencyPicker.dataSource = self
        CurrencyPicker.delegate = self
        coinManager.delegate = self
    }
}

//MARK: - UIPickerViewDataSource

extension CoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return coinManager.cryptoList.count
        }
        else {
            return coinManager.currencyArray.count
        }
    }
}

//MARK: - UIPickerViewDelegate

extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return coinManager.cryptoList[row]
        }
        else {
            return coinManager.currencyArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let selectedCrypto = coinManager.cryptoList[row]
            coinManager.cryptoSelected = selectedCrypto
        }
        else {
            let selectedCurrency = coinManager.currencyArray[row]
            coinManager.currencySelected = selectedCurrency
        }
        coinManager.getCoinPrice()
    }
}

//MARK: - CoinManagerDelegate

extension CoinViewController: CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinCost.text = coin.priceString
            self.currencyLabel.text = coin.currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

