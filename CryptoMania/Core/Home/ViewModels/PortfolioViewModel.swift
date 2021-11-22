//
//  PortfolioViewModel.swift
//  CryptoMania
//
//  Created by Julio Collado on 15/11/21.
//

import Foundation
import Combine

class PortfolioViewModel: ObservableObject {
    @Published var selectedCoin: CoinModel? = nil
    @Published var quantityText: String = ""
    @Published var showSavedCheckmark: Bool = false
    
    var currentValue: Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
}
