//
//  PlayerDetailView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/22/22.
//

import SwiftUI

struct PlayerDetailView: View {
    let player: PlayerEntity
    
    var body: some View {
        
        VStack(spacing: 10) {
            VStack(spacing: 5) {
                // replace this cricle view with a call to the player image view
                Circle()
                    .frame(width: 225, height: 225)
                Text("#\(player.jerseyNumber)")
                Text(player.position)
                    .bold()
                Text("\(player.playerHeight) cm")
            }
            .font(.title3)
            .italic()
            
            Button {
                // Open a view with detailed profile
                print(player.cP)
            } label: {
                Text("View Detailed Profile")
            }
            .buttonStyle(.bordered)
            
            TestTableView()
                        
            Button {
                // Open a view with a listing of games played
            } label: {
                Text("View All Games")
            }
            .buttonStyle(.bordered)
            
            Button {
                // Open a view with the player's summary stats
            } label: {
                Text("Summary Player Stats")
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .navigationTitle(player.fullName)
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlayerDetailView(player: PlayerEntity(context: DataManager.preview.container.viewContext))
        }
    }
}
