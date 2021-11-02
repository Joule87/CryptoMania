//
//  HomeViewModel.swift
//  CryptoMania
//
//  Created by Julio Collado on 2/11/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolio: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolio.append(DeveloperPreview.instance.coin)
        }
    }
}
