//
//  HintUsageFacade.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 07.03.2022.
//

import UIKit
enum HintType {
    case callFriend, audienceHelp, hideInvalids
}

final class HintUsageFacade {
    private var question: Question?
    private var hintCounters = [HintType: Int]()
    private var hints = [HintType: [HintProtocol]]()
    init(hints: [HintProtocol]) {
        for hint in hints {
            var hintsArray = self.hints[hint.hintType] ?? [HintProtocol]()
            hintsArray.append(hint)
            self.hints[hint.hintType] = hintsArray
        }
        self.hints.forEach { self.hintCounters[$0.key] = $0.value.count }
    }

    func setQuestion(question: Question?) {
        self.question = question
    }

    func callFriend() -> [Int] {
        return applyHintType(hints: hints[.callFriend])
    }

    func useAudienceHelp() -> [Int] {
        return applyHintType(hints: hints[.audienceHelp])
    }

    func use50to50Hint() -> [Int]? {
        return applyHintType(hints: hints[.hideInvalids])
    }

    private func applyHintType(hints: [HintProtocol]?) -> [Int] {
        var results = [Int]()
        guard let hints = hints else { return results }
        for hint in hints {
            if let count = hintCounters[hint.hintType],
               count > 0
            {
                if let hintResult = hint.apply(question: question) {
                    results.append(contentsOf: hintResult)
                }
                hintCounters[hint.hintType] =  count - 1
            } else {
                break
            }
        }
        return results
    }
}
