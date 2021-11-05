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
        dataService.$allCoins
            .sink { [weak self] receivedCoins in
                guard let self = self else { return }
                self.allCoins = receivedCoins
            }
            .store(in: &cancellables)
    }
}
