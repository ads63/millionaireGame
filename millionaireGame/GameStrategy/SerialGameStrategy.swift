//
//  SerialGameStrategy.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 03.03.2022.
//

import Foundation
final class SerialGameStrategy: GameStrategy {
    func getDescription() -> String {
        "Последовательно"
    }

    func getQuestion(questions: [Question], weight: Int? = nil) -> Question? {
        let weight = weight ?? 0
        return questions
            .filter { $0.weight > weight }
            .sorted(by: { $0.weight < $1.weight }).first
    }
}
