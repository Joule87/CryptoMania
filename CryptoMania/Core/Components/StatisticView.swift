//
//  StatisticView.swift
//  CryptoMania
//
//  Created by Julio Collado on 12/11/21.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .rotationEffect(
                        (stat.percentageChange?.isLess(than: 0) ?? false) ? Angle.init(degrees: 180) : .zero
                    )
                Text(stat.percentageChange?.asPercentString ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(
                (stat.percentageChange?.isLess(than: 0) ?? false) ? Color.theme.red : Color.theme.green
            )
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat1)
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            StatisticView(stat: dev.stat2)
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            StatisticView(stat: dev.stat3)
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
