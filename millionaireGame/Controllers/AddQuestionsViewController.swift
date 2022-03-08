//
//  AddQuestionsViewController.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 03.03.2022.
//

import UIKit

class AddQuestionsViewController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    var builder: QuestionsBuilder?
    var questionsCounter = 0
    @IBOutlet var tableView: UITableView!

    @IBAction func plusQuestionButton(_ sender: UIButton) {
        questionsCounter = builder?.addQuestion() ?? 0
        let indexPath = IndexPath(row: questionsCounter - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @IBAction func addQuestionsButton(_ sender: UIButton) {
        if let questions = builder?.build() {
            Game.instance.addQuestions(questions: questions)
        }
        dismiss(animated: true,
                completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        questionsCounter = builder?.addQuestion() ?? 0
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        builder = QuestionsBuilder()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 237
        tableView.rowHeight = 237
        tableView.register(
            UINib(
                nibName: "QuestionTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "questionCell")
        hideKeyboardWhenTapped()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        questionsCounter
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "questionCell",
            for: indexPath) as? QuestionTableViewCell
        else { return UITableViewCell() }
        cell.delegate = self
        cell.configure(indexPath: indexPath)
        return cell
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
