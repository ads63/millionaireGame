//
//   GameStrategy.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 03.03.2022.
//

import Foundation
protocol GameStrategy {
    func getDescription() -> String
    func getQuestion(questions: [Question], weight: Int?) -> Question?
}
