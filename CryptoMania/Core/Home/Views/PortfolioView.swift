//
//  PortfolioView.swift
//  CryptoMania
//
//  Created by Julio Collado on 15/11/21.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack(spacing: 10) {
                            ForEach(viewModel.allCoins) { coin in
                                CoinLogoView(coin: coin)
                                    .frame(width: 75)
                                    .padding(5)
                                    .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.theme.green, lineWidth: 0.5)
                                    )
                            }
                        }
                    })
                    .padding(.vertical, 4)
                    .padding(.leading)
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeViewModel)
    }
}
