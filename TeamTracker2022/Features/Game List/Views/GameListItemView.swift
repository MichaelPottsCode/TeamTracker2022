//
//  GameListItemView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 1/7/23.
//

import SwiftUI

struct GameListItemView: View {
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text("West Springfield  HS")
                    .font(.title2)
                    .fontWeight(.bold)
                VStack {
                    Text("High School Game")
                    Text("February 20, 2023")
                }
                .italic()
                .foregroundColor(.secondary)
            }
            
            Spacer()
            // color coded for win, loss, draw
            // this should be a computed property for the game entity
            Text("W 12-10")
                .fontWeight(.bold)
                .frame(width: 75, alignment: .trailing)
                .border(.red)
        }
    }
}

struct GameListItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameListItemView()
    }
}
