//
//  50to50Hint.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 08.03.2022.
//

import Foundation

final class HideInvalidAnswersHint: HintProtocol {
    let hintType = HintType.hideInvalids
    func apply(question: Question?) -> [Int]? {
        guard let question = question else { return [] }
        var answers = question.answers
        if answers.count < 3 { return [] } // ignore hide in cases 1,2 answers
        answers.removeValue(forKey: question.validAnswerId)
        let count2Delete = answers.count / 2
        for _ in 1 ... count2Delete {
            guard let key = answers.randomElement()?.key else {
                return answers.map { $0.key } // nothing to remove, it's impossible
            }
            answers.removeValue(forKey: key)
        }
        return answers.map { $0.key }
    }
}
