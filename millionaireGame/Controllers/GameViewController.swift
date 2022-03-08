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

    @IBOutlet var answersStack: UIStackView!
    @IBOutlet var statisticsLabel: UILabel!
    @IBOutlet var questionPriceLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var currentSumLabel: UILabel!
    @IBOutlet var stackHeightConstraint: NSLayoutConstraint!
    @IBOutlet var audienceHelpButton: UIButton!
    @IBOutlet var callFriendButton: UIButton!
    @IBOutlet var hideWrongAnswersButton: UIButton!

    @IBAction func callFriendAction(_ sender: UIButton) {
        sender.isEnabled = false
        animateButton(keys: delegate?.hintUsageFacade.callFriend())
    }

    @IBAction func audienceHelpAction(_ sender: UIButton) {
        sender.isEnabled = false
        animateButton(keys: delegate?.hintUsageFacade.useAudienceHelp())
    }

    @IBAction func hideWrongAnswersAction(_ sender: UIButton) {
        sender.isEnabled = false
        hideButtons(keys: delegate?.hintUsageFacade.use50to50Hint())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        delegate?.addTotalQuestions(count: dataProvider.getQuestionsCount())
        Game.instance.session?
            .answeredCount
            .addObserver(self,
                         removeIfExists: true,
                         options: [.initial, .new],
                         closure: { [weak self] count, _ in
                             let number = count + 1
                             if let total = self?.dataProvider.getQuestionsCount() {
                                 self?.statisticsLabel.text =
                                     "вопрос \(number) (верных ответов \((100 * count) / total)%)"
                             }
                         })
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        question = dataProvider.getQuestion()
        delegate?.hintUsageFacade.setQuestion(question: question)
        if !setQuestion(question: question) { exitGameSession() }
    }

    private func animateButton(keys: [Int]?) {
        guard let keys = keys,
              let answersButtons = answersButtons else { return }
        for key in keys {
            if let button = answersButtons[key] {
                UIView.animate(withDuration: 0.2,
                               animations: {
                                   button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                               },
                               completion: { _ in
                                   UIView.animate(withDuration: 0.2) {
                                       button.transform = CGAffineTransform.identity
                                   }
                               })
            }
        }
    }

    private func hideButtons(keys: [Int]?) {
        if let answersButtons = answersButtons,
           let keys = keys
        {
            keys.forEach {
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
                delegate?.hintUsageFacade.setQuestion(question: question)
            }
        }
        if !setQuestion(question: question) {
            exitGameSession()
        }
    }

    private func exitGameSession() {
        Game.instance.calcResults()
        dismiss(animated: true,
                completion: nil)
    }

    @objc func pressAnswerButton(sender: UIButton!) {
        checkAnswer(button: sender)
    }

    private func setQuestion(question: Question?) -> Bool {
        guard let question = question else {
            return false
        }
        answersButtons?.removeAll()
        answersStack.removeFullyAllArrangedSubviews()
        let buttonHeight = CGFloat(40.0)
        let stackHeight = CGFloat(question.answers.count)
            * (buttonHeight + answersStack.spacing)
        stackHeightConstraint.constant = stackHeight
        question.answers.forEach { key, value in
            let button = UIButton()
            button.frame = CGRect(x: CGFloat(0.0),
                                  y: CGFloat(0.0),
                                  width: answersStack.frame.width,
                                  height: buttonHeight)

            button.backgroundColor = .blue
            button.setTitleColor(.white, for: .normal)
            button.setTitle(value, for: .normal)
            button.isHidden = false
            button.isEnabled = true
            button.addTarget(self, action: #selector(pressAnswerButton),
                             for: .touchUpInside)
            answersButtons?[key] = button
            answersStack.addArrangedSubview(button)
        }
        answersStack.layoutIfNeeded()
        questionLabel.text = question.questionText
        currentSumLabel.text = "Выигрыш \(delegate?.getSum() ?? 0)"
        questionPriceLabel.text = "Цена вопроса \(question.weight)"
        return true
    }

    private func setButtons() {
        answersButtons = [Int: UIButton]()
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
