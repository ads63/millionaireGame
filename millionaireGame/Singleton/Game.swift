//
//  Game.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation

final class Game {
    static let instance = Game()
    var session: GameSession?
    var results = [GameSessionResult]()

    func calcResults() {
        guard let gameSession = self.session else { return }
        let count = gameSession.getAnsweredCount()
        let totalCount = gameSession.getTotalCount()
        self.results.append(
            GameSessionResult(
                money: gameSession.getSum(),
                answeredCount: count,
                answeredPercent: totalCount == 0 ? 0 : (count * 100) / totalCount
            )
        )
        try? CareTaker<[GameSessionResult]>().save(data: self.results)
        self.session = nil
    }
}
