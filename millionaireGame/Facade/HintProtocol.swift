//
//  HintProtocol.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 08.03.2022.
//

import Foundation
protocol HintProtocol {
    var hintType: HintType { get }
    func apply(question: Question?) -> [Int]?
}
