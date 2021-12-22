//
//  GameSessionDeledate.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 16.12.2021.
//

import Foundation

protocol GameSessionDelegate: AnyObject {
    func hideWrongAnswers(question: Question)
    func setNextQuestion(question: Question?,
                         answer: Int,
                         sum: Int,
                         savedSum: Int,
                         isCallEnabled: Bool,
                         isAudienceEnabled: Bool,
                         isHide1Enabled: Bool,
                         isHide2Enabled: Bool)
    func gameOver(sum: Int)
    func applyHint(hint: Hint)
}

enum Hint {
    case call, audience, fifty1, fifty2
}
