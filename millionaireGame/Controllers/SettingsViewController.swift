//
//  SettingsViewController.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 03.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var strategySelector: UISegmentedControl!
    @IBAction func strategyChangeAction(_ sender: UISegmentedControl) {
        Game.instance.currentStrategy = sender.selectedSegmentIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setControls()
    }

    private func setControls() {
        strategySelector.removeAllSegments()
        Game.instance.strategies.enumerated().forEach {
            strategySelector.insertSegment(withTitle: $0.element.getDescription(),
                                           at: $0.offset,
                                           animated: true)
        }
        strategySelector.selectedSegmentIndex = Game.instance.currentStrategy
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
