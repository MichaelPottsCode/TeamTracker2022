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
//                        withAnimation {
//                            playerListVM.addPlayer()
                            isAddingNewPlayer.toggle()
                            modalType = .new
//                        }
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
//            .sheet(item: $modalType, onDismiss: playerListVM.loadPlayers, content: { player in
//                <#code#>
//            })
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
