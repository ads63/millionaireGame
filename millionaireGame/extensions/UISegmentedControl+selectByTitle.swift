//
//  UISegmentedControl+selectByTitle.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 07.03.2022.
//

import UIKit
extension UISegmentedControl {
    func selectByTitle(title: String) {
        for index in 0 ..< self.numberOfSegments {
            if self.titleForSegment(at: index) == title {
                self.selectedSegmentIndex = index
                break
            }
        }
    }
}
