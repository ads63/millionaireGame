//
//  QuestionsBuilder.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 06.03.2022.
//

import Foundation
final class QuestionsBuilder {
    private var questions = [Question]()

    func getQuestion(at: Int) -> Question? {
        if (0..<questions.count).contains(at) {
            return questions[at]
        }
        return nil
    }

    func build() -> [Question] {
        // returns only valid Questions
        return questions.filter {
            $0.answers.count == 4
                && $0.weight > 0
                && $0.answers.map { $0.key }.contains($0.validAnswerId)
                && !$0.questionText.isEmpty
        }
    }

    func addQuestion() -> Int {
        questions.append(Question())
        return questions.count
    }

    func addQuestionText(index: Int?, questionText: String?) {
        if let index = index,
           let questionText = questionText,
           (0..<questions.count).contains(index)
        {
            questions[index].questionText = questionText
        }
    }

    func addAnswerText(index: Int?, answerText: String?, key: Int) {
        if let index = index,
           let answerText = answerText,
           !answerText.isEmpty,
           (0..<questions.count).contains(index)
        {
            questions[index].answers[key] = answerText
        }
    }

    func addWeight(index: Int?, weight: Int?) {
        if let index = index,
           let weight = weight,
           weight > 0,
           (0..<questions.count).contains(index)
        {
            questions[index].weight = weight
        }
    }

    func addValidAnswer(index: Int?, key: Int) {
        if let index = index,
           (0..<questions.count).contains(index)
        {
            questions[index].validAnswerId = key
        }
    }
}
