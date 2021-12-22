//
//  Question.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 15.12.2021.
//

import Foundation

struct Question {
    let id: Int
    var answers: [Answer]
    let questionText: String
    let level: Int

    init(id: Int, answers: [Answer], question: String, level: Int) {
        self.id = id
        self.answers = answers
        self.questionText = question
        self.level = level
    }
}
