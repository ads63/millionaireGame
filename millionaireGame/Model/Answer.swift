//
//  Answer.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 17.12.2021.
//

import Foundation
struct Answer {
    let text: String
    let isValid: Bool
    var isEnabled = true
    init(text: String, isValid: Bool) {
        self.text = text
        self.isValid = isValid
    }
}
