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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(playerListVM.players) { player in
                    NavigationLink(value: player) {
                        PlayerListItemView(player: player)
                    }
                }
                .onDelete(perform: playerListVM.deletePlayer)
            }
            .navigationDestination(for: PlayerEntity.self, destination: { player in
                Text(player.fullName)
            })
            .listStyle(.plain)
            .navigationTitle("Players")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
//                            playerListVM.addPlayer()
                            isAddingNewPlayer.toggle()
                        }
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
            .sheet(isPresented: $isAddingNewPlayer, onDismiss: playerListVM.loadPlayers) {
                PlayerFormView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
