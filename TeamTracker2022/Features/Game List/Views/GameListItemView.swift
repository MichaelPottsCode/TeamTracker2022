//
//  GameListItemView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 1/7/23.
//

import SwiftUI

struct GameModel {
    let opponent: String
    let ourScore: Int
    let opponentScore: Int
    let dateOfGame: Date
    let gameDuration: Int
    let gameType: String
    
    var dateOfGameAsString: String {
        dateOfGame.formatted(date: .long, time: .omitted)
    }
    
    var gameResult: some View {
        if ourScore > opponentScore {
            return Text("W \(ourScore)-\(opponentScore)")
                .foregroundColor(.green)
                .fontWeight(.bold)
        } else if ourScore < opponentScore {
            return Text("L \(ourScore)-\(opponentScore)")
                .foregroundColor(.red)
                .fontWeight(.bold)
        } else {
            return Text("D \(ourScore)-\(opponentScore)")
                .foregroundColor(.secondary)
                .fontWeight(.bold)
        }
    }
}

struct GameListItemView: View {
    let game: GameEntity
//    let game = GameModel(opponent: "Arlington Blue 2007B",
//                         ourScore: 3,
//                         opponentScore: 2,
//                         dateOfGame: Date(),
//                         gameDuration: 80,
//                         gameType: "Club")
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(game.opponent)
                    .font(.title2)
                    .fontWeight(.bold)
                VStack(alignment: .leading) {
//                    Text("\(game.gameType) Game")
                    Text(game.dateOfGameAsString)
                }
                .italic()
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            game.gameResult
                .frame(width: 75, alignment: .trailing)
//                .border(.red)
        }
    }
}

//struct GameListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameListItemView()
//    }
//}
