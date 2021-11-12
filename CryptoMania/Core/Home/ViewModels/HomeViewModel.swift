//
//  HomeViewModel.swift
//  CryptoMania
//
//  Created by Julio Collado on 2/11/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolio: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
//No needed given that bellow subscription resolved the updating as well
//        dataService.$allCoins
//            .sink { [weak self] receivedCoins in
//                guard let self = self else { return }
//                self.allCoins = receivedCoins
//            }
//            .store(in: &cancellables)
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
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
}
