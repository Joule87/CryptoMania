//
//  CircleButtonAnimationView.swift
//  CryptoMania
//
//  Created by Julio Collado on 31/10/21.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? Animation.easeOut(duration: 1) : .none)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
            .padding()
            .foregroundColor(.red)
            .frame(width: 200, height: 200, alignment: .center)
    }
}
