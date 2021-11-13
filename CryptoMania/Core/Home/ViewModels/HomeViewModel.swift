//
//  HomeViewModel.swift
//  CryptoMania
//
//  Created by Julio Collado on 2/11/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    //MARK:- Publishers
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolio: [CoinModel] = []
    @Published var searchText: String = ""
    
    //MARK:- Services
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    //MARK:- Subscriptions
    private func addSubscribers() {
        coinDataSubscription()
        marketDataSubscription()
    }
    
    private func marketDataSubscription() {
        marketDataService.$marketData
            .map(mappedMarketDataModel)
            .sink { [weak self] returnedStats in
                guard let self = self else { return }
                self.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    private func coinDataSubscription() {
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    //MARK:- Help Functions
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercaseText = text.lowercased()
        let filteredCoins = coins.filter({
            return $0.name.lowercased().contains(lowercaseText) ||
                $0.symbol.lowercased().contains(lowercaseText) ||
                $0.id.lowercased().contains(lowercaseText)
        })
        
        return filteredCoins
    }
    
    private func mappedMarketDataModel(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        guard let marketDataModel = marketDataModel else {
            return []
        }
        var stats = [StatisticModel]()
        let marketCap = StatisticModel(title: "Market Cap", value: marketDataModel.marketCap, percentageChange: marketDataModel.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h volume", value: marketDataModel.volume)
        let dominance = StatisticModel(title: "Dominance", value: marketDataModel.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio value", value: "$0.00", percentageChange: 0.0)
        
        stats.append(contentsOf: [marketCap, volume, dominance, portfolio])
        
        return stats
    }
}
