//
//  GameListView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 1/7/23.
//

import SwiftUI

struct GameListView: View {
    var body: some View {
        VStack {
            List {
                // add for each
                // add NavigationLink
                GameListItemView()
                GameListItemView()
                GameListItemView()
            }
            .listStyle(.plain)
            // deletion of game. confirm deletion with alert
            // add swipe action for edit of game
            // implement Stewart Lynch's dual use form concept
            // add NavigationDestination
        }
        .navigationTitle("Noah's Games")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // trigger adding a game
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameListView()
        }
    }
}
