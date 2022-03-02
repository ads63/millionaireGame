//
//  GameSessionResult.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation
struct GameSessionResult: Codable {
    var money = 0
    var answered = 0
    var percent = 0

    init(money: Int, answeredCount: Int, answeredPercent: Int) {
        self.money = money
        self.answered = answeredCount
        self.percent = answeredPercent
    }

    func description() -> String {
        "Сумма: " + String(money) +
            " Ответы: " + String(answered) +
            " Проценты: " + String(percent)
    }

    enum CodingKeys: String, CodingKey {
        case money
        case answered
        case percent
    }
}
