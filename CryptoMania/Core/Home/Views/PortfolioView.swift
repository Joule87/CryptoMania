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
                ForEach(homeViewModel.allCoins) { coin in
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
                                viewModel.selectedCoin = coin
                            }
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
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
        // me quede aqui ,,, 
        viewModel.savePortfolio()
        withAnimation(.easeOut) {
            removeSelectedCoin()
        }
        UIApplication.shared.endEditing()
    }
    
    private func removeSelectedCoin() {
        viewModel.selectedCoin = nil
        viewModel.quantityText = ""
    }
}
