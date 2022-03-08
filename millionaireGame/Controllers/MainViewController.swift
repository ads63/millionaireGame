//
//  MainViewController.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBAction func resultsButton(_ sender: UIButton) {
        resultsLabel.text = getResults()
    }

    @IBAction func settingsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "settingsSegue", sender: sender)
    }

    @IBOutlet var resultsLabel: UILabel!
    @IBAction func playButton(_ sender: UIButton) {
        performSegue(withIdentifier: "playSegue", sender: sender)
    }

    override func viewDidLoad() {
        try? Game.instance.results = CareTaker<[GameSessionResult]>().load()
            ?? [GameSessionResult]()
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
            if Game.instance.session == nil {
                let session = GameSession()
                Game.instance.session = session
                destinationVC.delegate = session
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    private func getResults() -> String {
        return Game.instance.results.isEmpty ?
            "Статистика игр отсутствует" :
            Game.instance.results
            .map { $0.description() }
            .reversed()
            .joined(separator: "\n")
    }
}
