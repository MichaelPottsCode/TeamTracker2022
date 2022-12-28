//
//  ContentView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import CoreData
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
//                PlayerListItemView(player: player)
                PlayerDetailView(player: player)
            })
//            .refreshable {
//                playerListVM.loadPlayers()
//            }
            .listStyle(.plain)
            .navigationTitle("Players")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addPlayer
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    settings
                }
            }
            .sheet(item: $formType) {
                Task {
                    playerListVM.loadPlayers()
                }
            } content: { $0 }
        }
    }
    
    var settings: some View {
        Button {
            // Add a link to the Settings view
        } label: {
            Symbols.settings
        }
    }
    
    var addPlayer: some View {
        Button {
            formType = .new
        } label: {
            Text("Add player")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
