//
//  Level.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 19.12.2021.
//

import Foundation
struct Level {
    let level: Int
    let weight: Int
    let isProofed: Bool
    init(level: Int, weight: Int, isProofed: Bool) {
        self.level = level
        self.weight = weight
        self.isProofed = isProofed
    }
}
