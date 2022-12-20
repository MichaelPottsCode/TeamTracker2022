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
    @State private var formType: PlayerFormType?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(playerListVM.players) { player in
                    NavigationLink(value: player) {
                        PlayerListItemView(player: player)
//                        PlayerListItemView2(id: player.objectID)
                        
//                            .overlay {
//                                Text("Edit")
//                            }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                        Button {
                            formType = .update(player)
                        } label: {
                            Text("Edit")
                        }
                        .tint(.blue)

                    })
                }
                .onDelete(perform: playerListVM.deletePlayer)
            }
            .navigationDestination(for: PlayerEntity.self, destination: { player in
//                PlayerImageView(image: player.uiImage)
                PlayerListItemView(player: player)
            })
            .listStyle(.plain)
            .navigationTitle("Players")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        formType = .new
                    } label: {
                        Text("Add player")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // Add a link to the Settings view
                    } label: {
                        Symbols.settings
                    }
                }
            }
            .sheet(item: $formType) {
                Task {
                    playerListVM.loadPlayers()
                }
            } content: { $0 }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
