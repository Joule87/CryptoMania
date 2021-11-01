//
//  ContentView.swift
//  CryptoMania
//
//  Created by Julio Collado on 29/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack(spacing: 40) {
                Text("Accent COlor")
                    .foregroundColor(Color.theme.accent)
                Text("secondary COlor")
                    .foregroundColor(Color.theme.secondaryText)
                Text("red COlor")
                    .foregroundColor(Color.theme.red)
                Text("green COlor")
                    .foregroundColor(Color.theme.green)
            }
            .font(.title)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
