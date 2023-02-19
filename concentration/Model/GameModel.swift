//
//  GameModel.swift
//  concentration
//
//  Created by Olha Dzhyhirei on 2/14/23.
//

import Foundation

protocol GameFinished {
    func gameWasFinished()
}

class Game {
    enum Level {
        case easy, medium, hard
    }
    
    var balls = [Ball]()
    var showingOneBallIndex: Int?
    var gameFinished: GameFinished?
    
    init(numberOfPairsOfBalls: Level) {
        var qountity = 0
        switch numberOfPairsOfBalls {
        case .easy:
           qountity = 8
        case .medium:
            qountity = 12
        case .hard:
            qountity = 18
        }
        for _ in 1...qountity {
            let ball = Ball()
            balls += [ball, ball]
        }
    }
    
    func chooseBall(at index: Int) {
        if !balls[index].isMathced {
            if let matchIndex = showingOneBallIndex, matchIndex != index {
                if balls[matchIndex].identifier == balls[index].identifier {
                    balls[matchIndex].isMathced = true
                    balls[index].isMathced = true
                }
                balls[index].isShowing = true
                showingOneBallIndex = nil
            } else {
                for flipDownIndex in balls.indices {
                    balls[flipDownIndex].isShowing = false
                }
                balls[index].isShowing = true
                showingOneBallIndex = index
            }
        }
    }
    
    func gameEnd() {
        if balls.allSatisfy( { $0.isMathced } ) {
            gameFinished?.gameWasFinished()
        }
    }
}
