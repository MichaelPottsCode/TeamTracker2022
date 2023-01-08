//
//  GameListView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 1/7/23.
//

import SwiftUI

struct GameListView: View {
    // when the game list view is referenced for a player, pass in the array of GameEntity
//    let games: [GameEntity]
    @StateObject var gameListVM: GameListViewModel
    
    var body: some View {
        VStack {
            if gameListVM.games.isEmpty {
                Text("No Games")
            } else {
                List {
                    ForEach(gameListVM.games) { game in
                        NavigationLink(value: game) {
                            GameListItemView(game: game)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationDestination(for: GameEntity.self) { game in
                    GameListItemView(game: game)
//                    GameDetailView(for: game)
                }
                // deletion of game. confirm deletion with alert
                // add swipe action for edit of game
                // implement Stewart Lynch's dual use form concept
                // add NavigationDestination
            }
        }
        .navigationTitle("\(gameListVM.playerName)'s Games")
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
            GameListView(gameListVM: GameListViewModel(for: PlayerEntity(context: DataManager(inMemory: true).container.viewContext)))
        }
    }
}
