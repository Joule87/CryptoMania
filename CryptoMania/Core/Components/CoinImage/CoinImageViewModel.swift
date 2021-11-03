//
//  CoinImageViewModel.swift
//  CryptoMania
//
//  Created by Julio Collado on 3/11/21.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        dataService = CoinImageService(url: coin.image)
        addSubscribers()
        isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self] returnedImage in
                guard let self = self else { return }
                self.image = returnedImage
            })
            .store(in: &cancellables)
    }
}
