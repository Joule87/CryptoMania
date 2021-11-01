//
//  CryptoManiaApp.swift
//  CryptoMania
//
//  Created by Julio Collado on 29/10/21.
//

import SwiftUI

@main
struct CryptoManiaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
