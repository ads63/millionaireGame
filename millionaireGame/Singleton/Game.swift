//
//  Game.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 16.12.2021.
//

import Foundation
final class Game: Codable {
    static let instance = Game()
    var session: GameSession?
    var results = [GameSessionResults]()
    enum CodingKeys: String, CodingKey {
        case results
    }

    func calcResults() {
        guard let gameSession = Game.instance.session else { return }

        let result = GameSessionResults(money: gameSession.getSum(),
                                        answered: gameSession.getAnsweredCount(),
                                        percent: gameSession.getAnsweredCount()
                                            * 100 / gameSession.getQuestionsCount())
        results.append(result)
    }
}
