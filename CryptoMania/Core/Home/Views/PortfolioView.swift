//
//  PortfolioView.swift
//  CryptoMania
//
//  Created by Julio Collado on 15/11/21.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @ObservedObject private var viewModel: PortfolioViewModel
    
    init(viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $homeViewModel.searchText)
                    coinLogoList
                    
                    if viewModel.selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavButtons
                }
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(viewModel: dev.portfolioViewModel)
            .environmentObject(dev.homeViewModel)
            .preferredColorScheme(.dark)
    }
}


extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(homeViewModel.searchText.isEmpty ? homeViewModel.portfolio : homeViewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    viewModel.selectedCoin?.id == coin.id ? Color.theme.green : Color.clear
                                    , lineWidth: 1)
                        )
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        viewModel.selectedCoin = coin
        
        if let portfolioCoin = homeViewModel.portfolio.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            viewModel.quantityText = String(amount)
        } else {
            viewModel.quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack{
                Text("Current price of \(viewModel.selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(viewModel.selectedCoin?.currentPrice.asCurrencyWith6Decimals ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $viewModel.quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(viewModel.currentValue.asCurrencyWith2Decimals)
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .foregroundColor(Color.theme.green)
                .opacity(viewModel.showSavedCheckmark ? 1 : 0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
                    .font(.headline)
            })
            .opacity((viewModel.selectedCoin != nil &&
                        viewModel.selectedCoin?.currentHoldings != Double(viewModel.quantityText)) ? 1 : 0)
        }
    }
    
    private func saveButtonPressed() {
        guard let coin = viewModel.selectedCoin, let amount = Double(viewModel.quantityText) else {
            return
        }
        
        homeViewModel.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            viewModel.showSavedCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                self.viewModel.showSavedCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        viewModel.selectedCoin = nil
        viewModel.quantityText = ""
    }
}
