//
//  PlayerImageView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/14/22.
//

import SwiftUI

struct PlayerImageView: View {
    var size: CGFloat
    var highlightColor: Color
    
    init(size: CGFloat = 225, color: Color = .primary) {
        self.size = size
        self.highlightColor = color
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: size > 125 ? 5 : 3)
                .foregroundColor(highlightColor)
                .frame(width: size, height: size)
                .shadow(color: highlightColor, radius: 10, x: 0, y: 0)
            Image("noah")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
            .frame(width: size, height: size)
        }
    }
}

struct PlayerImageView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerImageView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
