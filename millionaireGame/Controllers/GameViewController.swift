//
//  GameViewController.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import UIKit
protocol GameViewControllerDelegate: AnyObject {
    func finishGame(sum: Int)
}

class GameViewController: UIViewController {
    var delegate: GameSessionDelegate?
    private let dataProvider = GameViewControllerDataProvider()
    private var question: Question?
    private var answersButtons: [Int: UIButton]?

    @IBOutlet var questionPriceLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var currentSumLabel: UILabel!
    @IBOutlet var answerButtonD: UIButton!
    @IBOutlet var answerButtonC: UIButton!
    @IBOutlet var answerButtonB: UIButton!
    @IBOutlet var answerButtonA: UIButton!
    @IBOutlet var audienceHelpButton: UIButton!
    @IBOutlet var callFriendButton: UIButton!
    @IBOutlet var hideWrongAnswersButton: UIButton!

    @IBAction func hideWrongAnswersAction(_ sender: UIButton) {
        sender.isEnabled = false
        delegate?.useHint(hintType: .hideInvalids)
        hideAnswers(buttonId: dataProvider.getAnswers2Hide(question: question))
    }


    @IBAction func callButton(_ sender: UIButton) {
        sender.isEnabled = false
        delegate?.useHint(hintType: .callFriend)
    }

    @IBAction func audienceHelpButton(_ sender: UIButton) {
        sender.isEnabled = false
        delegate?.useHint(hintType: .audienceHelp)
    }

    @IBAction func buttonD(_ sender: UIButton) { checkAnswer(button: sender) }

    @IBAction func buttonC(_ sender: UIButton) { checkAnswer(button: sender) }

    @IBAction func buttonB(_ sender: UIButton) { checkAnswer(button: sender) }

    @IBAction func buttonA(_ sender: UIButton) { checkAnswer(button: sender) }

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        delegate?.addTotalQuestions(count: dataProvider.getQuestionsCount())

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        question = dataProvider.getQuestion()
        if !setQuestion(question: question) { exitGameSession() }
    }

    private func hideAnswers(buttonId: [Int]?) {
        if let answersButtons = answersButtons,
           let buttonId = buttonId
        {
            buttonId.forEach {
                if let button = answersButtons[$0] { button.isHidden = true }
            }
        }
    }
    
    private func checkAnswer(button: UIButton) {
        let currentQuestion = question
        question = nil
        if let id = currentQuestion?.validAnswerId,
           let validButton = answersButtons?[id]
        {
            if button === validButton {
                delegate?.addAnsweredQuestion(weight: currentQuestion?.weight)
                question = dataProvider.getQuestion(weight: currentQuestion?.weight)
            }
        }
        if !setQuestion(question: question) { exitGameSession() }
    }

    private func exitGameSession() {
        Game.instance.calcResults()
        dismiss(animated: true,
                completion: nil)
    }

    private func setQuestion(question: Question?) -> Bool {
        guard let question = question else {
            return false
        }
        questionLabel.text = question.questionText
        currentSumLabel.text = "Выигрыш \(delegate?.getSum() ?? 0)"
        questionPriceLabel.text = "Цена вопроса \(question.weight)"
        answersButtons?.forEach {
            $0.value.setTitle(question.answers[$0.key], for: .normal)
            $0.value.isHidden = false
            $0.value.isEnabled = true
        }
        return true
    }

    private func setButtons() {
        answersButtons = [1: answerButtonA,
                          2: answerButtonB,
                          3: answerButtonC,
                          4: answerButtonD]
        hideWrongAnswersButton.setImage(UIImage(named: "50"),
                                        for: .normal)
        hideWrongAnswersButton.setImage(UIImage(named: "checkbox"),
                                        for: .disabled)
        audienceHelpButton.setImage(UIImage(named: "people"),
                                    for: UIControl.State.normal)
        audienceHelpButton.setImage(UIImage(named: "checkbox"),
                                    for: UIControl.State.disabled)
        callFriendButton.setImage(UIImage(named: "call"),
                                  for: UIControl.State.normal)
        callFriendButton.setImage(UIImage(named: "checkbox"),
                                  for: UIControl.State.disabled)
        hideWrongAnswersButton.isEnabled = true
        audienceHelpButton.isEnabled = true
        callFriendButton.isEnabled = true
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
