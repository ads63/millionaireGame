//
//  GameViewControllerDataProvider.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation

final class GameViewControllerDataProvider {
    private var questions = Game.instance.getQuestions()
    func getQuestionsCount() -> Int { Set(questions.map { $0.weight }).count }
    func getQuestion(weight: Int? = nil) -> Question? {
        return Game.instance.strategies[Game.instance.currentStrategy]
            .getQuestion(questions: questions, weight: weight)
    }

    func getAnswers2Hide(question: Question?) -> [Int] {
        guard let question = question else { return [] }
        var answers = question.answers
        if answers.count < 3 { return [] } // ignore hide in 1,2 cases
        answers.removeValue(forKey: question.validAnswerId)
        let count2Delete = answers.count / 2
        for _ in 1 ... count2Delete {
            guard let key = answers.randomElement()?.key else {
                return answers.map { $0.key } // nothing to remove - impossible
            }
            answers.removeValue(forKey: key)
        }
        return answers.map { $0.key }
    }
}
