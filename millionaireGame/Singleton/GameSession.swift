//
//  GameSession.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation
final class GameSession: GameSessionDelegate {
    var answeredCount = Observable<Int>(0)
    var hintUsageFacade = HintUsageFacade(hints:[AudienceHelpHint(),
                                                 CallFriendHint(),
                                                 HideInvalidAnswersHint()])
    private var currentSum: Int?
    private var totalCount = 0

    func addTotalQuestions(count: Int) {
        totalCount = count
    }

    func getSum() -> Int { currentSum ?? 0 }
    func getAnsweredCount() -> Int { answeredCount.value }
    func getTotalCount() -> Int { totalCount }

    func addAnsweredQuestion(weight: Int?) {
        if let weight = weight {
            answeredCount.value = 1 + (answeredCount.value)
            currentSum = weight + (currentSum ?? 0)
        }
    }
}
