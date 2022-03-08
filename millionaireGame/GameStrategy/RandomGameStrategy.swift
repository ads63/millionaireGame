//
//  RandomGameStrategy.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 03.03.2022.
//

import Foundation
final class RandomGameStrategy: GameStrategy {
    func getDescription() -> String {
        "Случайно"
    }

    func getQuestion(questions: [Question], weight: Int? = nil) -> Question? {
        let weight = weight ?? 0
        let questions = questions
            .filter { $0.weight > weight }
            .sorted(by: { $0.weight < $1.weight })
        guard let minWeight = questions.first?.weight else { return nil }
        return questions.filter { $0.weight == minWeight }.randomElement()
    }
}
