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
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    //MARK:- Subscriptions
    private func addSubscribers() {
        coinDataSubscription()
        marketDataSubscription()
        updatesPortfolioSubscription()
    }
    
    private func updatesPortfolioSubscription() {
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapPortfolioEntities)
            .sink { [weak self] returnedPortfolio in
                guard let self = self else { return }
                self.portfolio = returnedPortfolio
            }
            .store(in: &cancellables)
    }
    
    private func mapPortfolioEntities(allCoins: [CoinModel], portFolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portFolioEntities.first(where: { coin.id == $0.coinId}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
