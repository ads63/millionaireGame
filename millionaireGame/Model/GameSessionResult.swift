//
//  GameResult.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 20.12.2021.
//

import Foundation
struct GameSessionResults: Codable {
    let money: Int
    let answered: Int
    let percent: Int
    func toString() -> String {
        return "Сумма: " + String(money) +
            " Ответы: " + String(answered) +
            " Проценты: " + String(percent)
    }

    enum CodingKeys: String, CodingKey {
        case money
        case answered
        case percent
    }
}
