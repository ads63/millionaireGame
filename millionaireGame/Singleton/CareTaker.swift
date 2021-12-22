//
//  CareTaker.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 22.12.2021.
//

import Foundation

class CareTaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "game_results"

    func save(gameResults: [GameSessionResults]) throws {
        let data: Memento = try encoder.encode(gameResults)
        UserDefaults.standard.set(data, forKey: key)
    }

    func load() throws -> [GameSessionResults] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Memento,
              let gameResults = try? decoder.decode([GameSessionResults].self,
                                                    from: data)
        else {
            return [GameSessionResults]()
        }
        return gameResults
    }
}
