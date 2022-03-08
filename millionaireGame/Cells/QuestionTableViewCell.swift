//
//  QuestionTableViewCell.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 03.03.2022.
//

import UIKit
enum TextFieldTags: Int {
    case question = 100, answer1, answer2, answer3, answer4, price
}

class QuestionTableViewCell: UITableViewCell, UITextFieldDelegate {
    var delegate: AddQuestionsViewController?
    var textFields: [TextFieldTags: UITextField]?
    var answerKeys = [Int]()
    var indexValue: Int?

    @IBAction func validAnswerControl(_ sender: UISegmentedControl) {
        if let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex),
           let validAnswer = Int(selectedTitle)
        {
            delegate?.builder?.addValidAnswer(index: indexValue, key: validAnswer)
        }
    }

    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var answer4TextField: UITextField!
    @IBOutlet var answer3TextField: UITextField!
    @IBOutlet var answer2TextField: UITextField!
    @IBOutlet var answer1TextField: UITextField!
    @IBOutlet var questionTextField: UITextField!
    @IBOutlet var validAnswerSegmentedControl: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for segmentIndex in 0 ..< validAnswerSegmentedControl.numberOfSegments {
            answerKeys.append(Int(validAnswerSegmentedControl
                    .titleForSegment(at: segmentIndex)!)!)
        }
        textFields = [.question: questionTextField,
                      .answer1: answer1TextField,
                      .answer2: answer2TextField,
                      .answer3: answer3TextField,
                      .answer4: answer4TextField,
                      .price: priceTextField]
        textFields?.forEach {
            $0.value.delegate = self
            $0.value.tag = $0.key.rawValue
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch TextFieldTags(rawValue: textField.tag) {
        case .question:
            delegate?.builder?.addQuestionText(index: indexValue,
                                               questionText: textField.text)
        case .answer1:
            delegate?.builder?.addAnswerText(index: indexValue,
                                             answerText: textField.text,
                                             key: answerKeys[0])
        case .answer2:
            delegate?.builder?.addAnswerText(index: indexValue,
                                             answerText: textField.text,
                                             key: answerKeys[1])
        case .answer3:
            delegate?.builder?.addAnswerText(index: indexValue,
                                             answerText: textField.text,
                                             key: answerKeys[2])
        case .answer4:
            delegate?.builder?.addAnswerText(index: indexValue,
                                             answerText: textField.text,
                                             key: answerKeys[3])
        case .price:
            if let text = textField.text,
               let weight = Int(text)
            {
                delegate?.builder?.addWeight(index: indexValue, weight: weight)
            }
        default:
            break
        }
    }

    func configure(indexPath: IndexPath) {
        indexValue = indexPath.row
        guard let question = delegate?.builder?.getQuestion(at: indexValue!)
        else { return }
        questionTextField.text = question.questionText
        answer1TextField.text = question.answers[answerKeys[0]]
        answer2TextField.text = question.answers[answerKeys[1]]
        answer3TextField.text = question.answers[answerKeys[2]]
        answer4TextField.text = question.answers[answerKeys[3]]
        priceTextField.text = question.weight > 0 ? String(question.weight) : ""
        validAnswerSegmentedControl.selectByTitle(title: String(question.validAnswerId))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
