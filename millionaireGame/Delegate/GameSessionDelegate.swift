//
//  GameSessionDelegate.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation
protocol GameSessionDelegate {
    func addAnsweredQuestion(weight: Int?)
    func addTotalQuestions(count: Int)
    func useHint(hintType: HintType)
    func getSum() -> Int
}
