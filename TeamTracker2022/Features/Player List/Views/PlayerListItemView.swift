//
//  PlayerListItemView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import SwiftUI

struct PlayerListItemView: View {
    let player: PlayerEntity
    
    var body: some View {
        HStack {
            PlayerImageView(size: 65, playerImageID: player.imageID)
            VStack(alignment: .leading) {
                Text(player.fullName)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(player.position)
                    .italic()
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 5)
            Spacer()
        }
    }
}

struct PlayerListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListItemView(player: PlayerEntity(context: DataManager.preview.container.viewContext))
    }
}
