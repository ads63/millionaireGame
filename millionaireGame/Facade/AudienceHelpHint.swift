//
//  AudienceHelpHint.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 08.03.2022.
//

import Foundation
final class AudienceHelpHint: HintProtocol {
    let hintType = HintType.audienceHelp
    func apply(question: Question?) -> [Int]? {
        let hiddenAnswers = question?.hiddenAnswers ?? [Int]()
        guard let result = question?.answers
                .filter({ !hiddenAnswers.contains($0.key) }).map({ $0.key })
                .randomElement() else { return nil }
        return [result]
    }
}
