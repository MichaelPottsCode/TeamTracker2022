//
//  ContentView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import SwiftUI

struct PlayerListView: View {
    @StateObject private var playerListVM = PlayerListViewModel()
    @State private var isAddingNewPlayer: Bool = false
    @State private var modalType: PlayerModalType?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(playerListVM.players) { player in
                    NavigationLink(value: player) {
                        PlayerListItemView(player: player)
//                            .overlay {
//                                Text("Edit")
//                            }
                    }
                }
                .onDelete(perform: playerListVM.deletePlayer)
            }
            .navigationDestination(for: PlayerEntity.self, destination: { player in
                PlayerImageView(image: player.uiImage)
            })
            .listStyle(.plain)
            .navigationTitle("Players")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        modalType = .new
                    } label: {
                        Text("Add player")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //
                    } label: {
                        Symbols.settings
                    }
                }
            }
            .sheet(item: $modalType) {
                playerListVM.loadPlayers()
            } content: { $0 }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
