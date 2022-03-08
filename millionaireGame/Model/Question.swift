//
//  Question.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation

struct Question: Codable {
    var answers = [Int: String]()
    var validAnswerId: Int = 1
    var hiddenAnswers = [Int]()
    var questionText: String = ""
    var weight: Int = 0

    init(question: String = "",
         answers: [Int: String] = [Int: String](),
         validAnswer: Int = 1,
         weight: Int = 0)
    {
        self.validAnswerId = validAnswer
        self.answers = answers
        self.questionText = question
        self.weight = weight
    }

    enum CodingKeys: String, CodingKey {
        case answers
        case validAnswerId
        case questionText
        case weight
    }
}
