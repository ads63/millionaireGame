//
//  MainViewController.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 16.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBAction func resultsButton(_ sender: UIButton) {
        resultsLabel.text = getResults()
    }

    @IBOutlet var resultsLabel: UILabel!
    @IBAction func playButton(_ sender: UIButton) {
        performSegue(withIdentifier: "playSegue", sender: sender)
    }

    override func viewDidLoad() {
        try? Game.instance.results = CareTaker().load()
        resultsLabel.text = getResults()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playSegue" {
            guard let destinationVC = segue.destination
                as? GameViewController else { return }
            destinationVC.delegate = self
            if Game.instance.session == nil {
                Game.instance.session = GameSession()
            }
            destinationVC.sessionDelegate = Game.instance.session
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    private func getResults() -> String {
        return Game.instance.results.isEmpty ?
            "Статистика игр отсутствует" :
            Game.instance.results.map { $0.toString() }
            .reversed().joined(separator: "\n")
    }
}

extension MainViewController: GameViewControllerDelegate {
    func finishGame(sum: Int) {
        Game.instance.calcResults()
        try? CareTaker().save(gameResults: Game.instance.results)
        Game.instance.session = nil
    }
}
