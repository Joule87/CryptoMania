//
//  CoinImageView.swift
//  CryptoMania
//
//  Created by Julio Collado on 3/11/21.
//
import SwiftUI

struct CoinImageView: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else if viewModel.isLoading {
            ProgressView()
                .foregroundColor(Color.theme.secondaryText)
        } else {
            Image(systemName: "questionmark")
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
