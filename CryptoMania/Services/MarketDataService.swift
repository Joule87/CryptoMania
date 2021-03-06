//
//  MarketDataService.swift
//  CryptoMania
//
//  Created by Julio Collado on 13/11/21.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel?
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                guard let self = self else { return }
                self.marketData = returnedGlobalData.data
                self.marketDataSubscription?.cancel()
            })
    }
}
