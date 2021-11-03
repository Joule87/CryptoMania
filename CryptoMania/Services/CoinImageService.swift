//
//  CoinImageService.swift
//  CryptoMania
//
//  Created by Julio Collado on 3/11/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    
    init(url: String) {
        getCoinImage(url: url)
    }
    
    private func getCoinImage(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        imageSubscription =  NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
            })
    }
}
