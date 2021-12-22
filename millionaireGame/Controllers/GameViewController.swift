//
//  GameViewController.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 16.12.2021.
//

import UIKit
protocol GameViewControllerDelegate: AnyObject {
    func finishGame(sum: Int)
}

class GameViewController: UIViewController {
    var delegate: GameViewControllerDelegate?
    var sessionDelegate: GameSessionDelegate?
    var question: Question?

    @IBOutlet var questionPriceLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var savedSumLabel: UILabel!
    @IBOutlet var currentSumLabel: UILabel!
    @IBOutlet var answerButtonD: UIButton!
    @IBOutlet var answerButtonC: UIButton!
    @IBOutlet var answerButtonB: UIButton!
    @IBOutlet var answerButtonA: UIButton!
    @IBOutlet var hideWrongAnswerButton2: UIButton!
    @IBOutlet var audienceHelpButton: UIButton!
    @IBOutlet var callFriendButton: UIButton!
    @IBOutlet var hideWrongAnswerButton1: UIButton!

    @IBAction func hideWrongButton2(_ sender: UIButton) {
        guard let question = self.question else {
            return
        }
        sessionDelegate?.hideWrongAnswers(question: question)
        disableHint(button: sender, hint: Hint.fifty2)
    }

    @IBAction func hideWrongButton1(_ sender: UIButton) {
        guard let question = self.question else {
            return
        }
        sessionDelegate?.hideWrongAnswers(question: question)
        disableHint(button: sender, hint: Hint.fifty1)
    }

    @IBAction func callButton(_ sender: UIButton) {
        disableHint(button: sender, hint: Hint.call)
    }

    @IBAction func audienceHelpButton(_ sender: UIButton) {
        disableHint(button: sender, hint: Hint.audience)
    }

    @IBAction func buttonD(_ sender: UIButton) { selectAnswer(index: 3) }

    @IBAction func buttonC(_ sender: UIButton) { selectAnswer(index: 2) }

    @IBAction func buttonB(_ sender: UIButton) { selectAnswer(index: 1) }

    @IBAction func buttonA(_ sender: UIButton) { selectAnswer(index: 0) }

    private func disableHint(button: UIButton, hint: Hint) {
        sessionDelegate?.applyHint(hint: hint)
    }

    private func selectAnswer(index: Int) {
        sessionDelegate?.setNextQuestion(question: question,
                                         answer: index,
                                         sum: 0,
                                         savedSum: 0,
                                         isCallEnabled: callFriendButton.isEnabled,
                                         isAudienceEnabled: audienceHelpButton.isEnabled,
                                         isHide1Enabled: hideWrongAnswerButton1.isEnabled,
                                         isHide2Enabled: hideWrongAnswerButton2.isEnabled)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        Game.instance.session?.delegate = self

        // Do any additional setup after loading the view.
    }

    private func setButtons() {
        answerButtonA.setTitleColor(answerButtonA.backgroundColor, for: .disabled)
        answerButtonB.setTitleColor(answerButtonB.backgroundColor, for: .disabled)
        answerButtonC.setTitleColor(answerButtonC.backgroundColor, for: .disabled)
        answerButtonD.setTitleColor(answerButtonD.backgroundColor, for: .disabled)
        hideWrongAnswerButton2.setImage(UIImage(named: "50"),
                                        for: .normal)
        hideWrongAnswerButton2.setImage(UIImage(named: "checkbox"),
                                        for: .disabled)
        hideWrongAnswerButton1.setImage(UIImage(named: "50"),
                                        for: UIControl.State.normal)
        hideWrongAnswerButton1.setImage(UIImage(named: "checkbox"),
                                        for: UIControl.State.disabled)
        audienceHelpButton.setImage(UIImage(named: "people"),
                                    for: UIControl.State.normal)
        audienceHelpButton.setImage(UIImage(named: "checkbox"),
                                    for: UIControl.State.disabled)
        callFriendButton.setImage(UIImage(named: "call"),
                                  for: UIControl.State.normal)
        callFriendButton.setImage(UIImage(named: "checkbox"),
                                  for: UIControl.State.disabled)
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

extension GameViewController: GameSessionDelegate {
    func hideWrongAnswers(question: Question) {
        self.question = question
        answerButtonA.isEnabled = question.answers[0].isEnabled
        answerButtonB.isEnabled = question.answers[1].isEnabled
        answerButtonC.isEnabled = question.answers[2].isEnabled
        answerButtonD.isEnabled = question.answers[3].isEnabled
    }

    func applyHint(hint: Hint) {
        switch hint {
        case .call:
            callFriendButton.isEnabled = false
        case .audience:
            audienceHelpButton.isEnabled = false
        case .fifty1:
            hideWrongAnswerButton1.isEnabled = false
        case .fifty2:
            hideWrongAnswerButton2.isEnabled = false
        }
    }

    func setNextQuestion(question: Question?,
                         answer: Int,
                         sum: Int,
                         savedSum: Int,
                         isCallEnabled: Bool,
                         isAudienceEnabled: Bool,
                         isHide1Enabled: Bool,
                         isHide2Enabled: Bool)
    {
        guard let question = question else {
            return
        }
        self.question = question
        callFriendButton.isEnabled = isCallEnabled
        audienceHelpButton.isEnabled = isAudienceEnabled
        hideWrongAnswerButton1.isEnabled = isHide1Enabled
        hideWrongAnswerButton2.isEnabled = isHide2Enabled
        questionPriceLabel.text = "цена вопроса " + String(answer)
        questionLabel.text = question.questionText
        savedSumLabel.text = "несгораемая сумма " + String(savedSum)
        currentSumLabel.text = "сумма " + String(sum)
        answerButtonA.setTitle(question.answers[0].text, for: .normal)
        answerButtonB.setTitle(question.answers[1].text, for: .normal)
        answerButtonC.setTitle(question.answers[2].text, for: .normal)
        answerButtonD.setTitle(question.answers[3].text, for: .normal)

        answerButtonA.isEnabled = question.answers[0].isEnabled
        answerButtonB.isEnabled = question.answers[1].isEnabled
        answerButtonC.isEnabled = question.answers[2].isEnabled
        answerButtonD.isEnabled = question.answers[3].isEnabled
    }

    func gameOver(sum: Int) {
        delegate?.finishGame(sum: sum) // returns data to main
        dismiss(animated: true, completion: nil)
    }
}
