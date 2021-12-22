//
//  GameSession.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 16.12.2021.
//

import Foundation
class GameSession {
    weak var delegate: GameSessionDelegate? { didSet {
        setNextQuestion(isCallEnabled: self.call2Friend > 0,
                        isAudienceEnabled: self.audienceHelp > 0,
                        isHide1Enabled: self.removeInvalid1 > 0,
                        isHide2Enabled: self.removeInvalid2 > 0)
    }}
    private var call2Friend = 1
    private var audienceHelp = 1
    private var removeInvalid1 = 1
    private var removeInvalid2 = 1
    private var savedSum = 0
    private var currentSum = 0
    private var answered = [Question]()
    private var notAnswered = [Question]()
    private var questions = [
        Question(id: 1,
                 answers: [Answer(text: "Мотылек", isValid: true),
                           Answer(text: "Таракан", isValid: false),
                           Answer(text: "Муха", isValid: false),
                           Answer(text: "Японский хрущик", isValid: false)],
                 question: "Какое насекомое вызвало короткое замыкание в ранней версии вычислительной машины, тем самым породив термин «компьютерный баг» («баг» в переводе с англ. «насекомое»)?",
                 level: 1),
        Question(id: 2,
                 answers: [Answer(text: "Ананас", isValid: false),
                           Answer(text: "Вишня", isValid: false),
                           Answer(text: "Кокос", isValid: true),
                           Answer(text: "Абрикос", isValid: false)],
                 question: "Из каких плодов можно получить копру?",
                 level: 1),
        Question(id: 2,
                 answers: [Answer(text: "Ананас", isValid: false),
                           Answer(text: "Вишня", isValid: false),
                           Answer(text: "Кокос", isValid: true),
                           Answer(text: "Абрикос", isValid: false)],
                 question: "Из каких плодов можно получить копру?",
                 level: 1),
        Question(id: 3,
                 answers: [Answer(text: "Мегатрон", isValid: false),
                           Answer(text: "Наномоль", isValid: false),
                           Answer(text: "Гугол", isValid: true),
                           Answer(text: "Гигабит", isValid: false)],
                 question: "Под каким названием известна единица с последующими ста нулями?",
                 level: 2),
        Question(id: 4,
                 answers: [Answer(text: "Углерод", isValid: false),
                           Answer(text: "Кальций", isValid: false),
                           Answer(text: "Кислород", isValid: true),
                           Answer(text: "Железо", isValid: false)],
                 question: "Какой химический элемент составляет более половины массы тела человека?",
                 level: 2),
        Question(id: 5,
                 answers: [Answer(text: "Головной мозг", isValid: false),
                           Answer(text: "Шестая пара ребер", isValid: false),
                           Answer(text: "Шейный позвонок", isValid: true),
                           Answer(text: "Часть плеча", isValid: false)],
                 question: "Какую часть тела также называют «атлант»?",
                 level: 3),
        Question(id: 6,
                 answers: [Answer(text: "22", isValid: false),
                           Answer(text: "24", isValid: false),
                           Answer(text: "26", isValid: true),
                           Answer(text: "28", isValid: false)],
                 question: "Сколько кубиков в кубике Рубика",
                 level: 4),
        Question(id: 7,
                 answers: [Answer(text: "Символ мира", isValid: false),
                           Answer(text: "Инициалы дочери", isValid: true),
                           Answer(text: "Боже, храни Америку", isValid: false),
                           Answer(text: "Здесь был Юджин", isValid: false)],
                 question: "Что изобразил Юджин Сернан, последний на данный момент побывавший на Луне человек, на ее поверхности?",
                 level: 5),
        Question(id: 8,
                 answers: [Answer(text: "Даосизм", isValid: false),
                           Answer(text: "Индуизм", isValid: false),
                           Answer(text: "Иудаизм", isValid: false),
                           Answer(text: "Буддизм", isValid: true)],
                 question: "Одним из направлений какой религиозной философии является учение дзен?",
                 level: 6),
        Question(id: 9,
                 answers: [Answer(text: "3", isValid: false),
                           Answer(text: "4", isValid: false),
                           Answer(text: "5", isValid: false),
                           Answer(text: "6", isValid: true)],
                 question: "Сколько морей омывают Балканский полуостров?",
                 level: 7),
        Question(id: 10,
                 answers: [Answer(text: "Паскаль", isValid: false),
                           Answer(text: "Ом", isValid: false),
                           Answer(text: "Вольт", isValid: true),
                           Answer(text: "Герц", isValid: false)],
                 question: "Какая единица измерения названа в честь итальянского дворянина?",
                 level: 8),
        Question(id: 11,
                 answers: [Answer(text: "Наименование места", isValid: true),
                           Answer(text: "Фамилия человека", isValid: false),
                           Answer(text: "Название растения", isValid: false),
                           Answer(text: "Название компании", isValid: false)],
                 question: "Что дало название джинсам?",
                 level: 9),
        Question(id: 12,
                 answers: [Answer(text: "Д. И. Фонвизин", isValid: false),
                           Answer(text: "Г. Р. Державин", isValid: false),
                           Answer(text: "А. Н. Радищев", isValid: true),
                           Answer(text: "Н. М. Карамзин", isValid: false)],
                 question: "Кто из перечисленных был пажом во времена Екатерины II?",
                 level: 10),
        Question(id: 13,
                 answers: [Answer(text: "Кения", isValid: false),
                           Answer(text: "Панама", isValid: false),
                           Answer(text: "Бразилия", isValid: false),
                           Answer(text: "Индонезия", isValid: true)],
                 question: "Какую страну не пересекает экватор?",
                 level: 11),
        Question(id: 14,
                 answers: [Answer(text: "Простой", isValid: false),
                           Answer(text: "Изученный", isValid: false),
                           Answer(text: "Маленький", isValid: false),
                           Answer(text: "Быстрый", isValid: true)],
                 question: "Что означает гавайское слово «вики», которое дало название интернет-энциклопедии «Википедия»?",
                 level: 12),
        Question(id: 14,
                 answers: [Answer(text: "Простой", isValid: false),
                           Answer(text: "Изученный", isValid: false),
                           Answer(text: "Маленький", isValid: false),
                           Answer(text: "Быстрый", isValid: true)],
                 question: "Что означает гавайское слово «вики», которое дало название интернет-энциклопедии «Википедия»?",
                 level: 12),
        Question(id: 15,
                 answers: [Answer(text: "Драпировка", isValid: false),
                           Answer(text: "Город", isValid: false),
                           Answer(text: "Стадо овец", isValid: false),
                           Answer(text: "Пейзаж", isValid: true)],
                 question: "Что изображено на заднем плане картины Леонардо да Винчи «Мона Лиза»?",
                 level: 13),
        Question(id: 16,
                 answers: [Answer(text: "Красное", isValid: true),
                           Answer(text: "Синее", isValid: false),
                           Answer(text: "Желтое", isValid: false),
                           Answer(text: "Зеленое", isValid: false)],
                 question: "Какого цвета крайнее правое кольцо в олимпийской символике?",
                 level: 14),
        Question(id: 17,
                 answers: [Answer(text: "плечом", isValid: false),
                           Answer(text: "челом", isValid: true),
                           Answer(text: "веслом", isValid: false),
                           Answer(text: "кнутом", isValid: false)],
                 question: "Чем в давние времена бил холоп, обращаясь к царю?",
                 level: 15),
        Question(id: 18,
                 answers: [Answer(text: "хвостом", isValid: false),
                           Answer(text: "глазами", isValid: false),
                           Answer(text: "слюной", isValid: false),
                           Answer(text: "языком", isValid: true)],
                 question: "Чем способен «стрелять» хамелеон?",
                 level: 1)
    ]

    private var levels: [Level] = [Level(level: 1, weight: 100, isProofed: false),
                                   Level(level: 2, weight: 200, isProofed: false),
                                   Level(level: 3, weight: 300, isProofed: false),
                                   Level(level: 4, weight: 500, isProofed: false),
                                   Level(level: 5, weight: 1000, isProofed: true),
                                   Level(level: 6, weight: 2000, isProofed: false),
                                   Level(level: 7, weight: 4000, isProofed: false),
                                   Level(level: 8, weight: 8000, isProofed: false),
                                   Level(level: 9, weight: 16000, isProofed: false),
                                   Level(level: 10, weight: 32000, isProofed: true),
                                   Level(level: 11, weight: 64000, isProofed: false),
                                   Level(level: 12, weight: 125000, isProofed: false),
                                   Level(level: 13, weight: 250000, isProofed: false),
                                   Level(level: 14, weight: 500000, isProofed: false),
                                   Level(level: 15, weight: 1000000, isProofed: false)]
    func getSum() -> Int {
        return self.savedSum
    }

    func getAnsweredCount() -> Int {
        return self.answered.count
    }

    func getQuestionsCount() -> Int {
        return self.answered.count + self.questions.count + self.notAnswered.count
    }
}

extension GameSession: GameSessionDelegate {
    func hideWrongAnswers(question: Question) {
        var question = question
        var hideCount = 2
        if removeInvalid1 > 0 || removeInvalid2 > 0 {
            for (index, answer) in question.answers.enumerated() {
                if !answer.isValid, answer.isEnabled, hideCount > 0 {
                    question.answers[index].isEnabled = false
                    hideCount -= 1
                }
                if hideCount == 0 { break }
            }
            delegate?.hideWrongAnswers(question: question)
        }
    }

    func applyHint(hint: Hint) {
        switch hint {
        case .call:
            self.call2Friend = 0
        case .audience:
            self.audienceHelp = 0
        case .fifty1:
            self.removeInvalid1 = 0
        case .fifty2:
            self.removeInvalid2 = 0
        }
        delegate?.applyHint(hint: hint)
    }

    func gameOver(sum: Int = 0) {
        self.savedSum = sum
    }

    func setNextQuestion(question: Question? = nil,
                         answer: Int = 0,
                         sum: Int = 0,
                         savedSum: Int = 0,
                         isCallEnabled: Bool,
                         isAudienceEnabled: Bool,
                         isHide1Enabled: Bool,
                         isHide2Enabled: Bool)
    {
        var newQuestion: Question?
        guard let question = question else {
            let newQuestion = questions.filter { $0.level == questions
                .map { $0.level }.min()
            }.first
            self.informDelegate(question: newQuestion)
            return
        }
        questions.removeAll(where: { $0.id == question.id })
        if question.answers[answer].isValid {
            answered.append(question)
            self.currentSum += levels[question.level-1].weight
            newQuestion = questions.filter { $0.level == question.level + 1 }.first
            if levels[question.level-1].isProofed { self.savedSum = self.currentSum }
            if newQuestion == nil { self.gameOver(sum: self.currentSum) }
        } else { notAnswered.append(question) }

        self.informDelegate(question: newQuestion)
    }

    private func informDelegate(question: Question?) {
        guard let question = question else {
            delegate?.gameOver(sum: self.savedSum)
            return
        }
        let answer = levels[question.level-1].weight
        delegate?.setNextQuestion(question: question,
                                  answer: answer,
                                  sum: self.currentSum,
                                  savedSum: self.savedSum,
                                  isCallEnabled: self.call2Friend > 0,
                                  isAudienceEnabled: self.audienceHelp > 0,
                                  isHide1Enabled: self.removeInvalid1 > 0,
                                  isHide2Enabled: self.removeInvalid2 > 0)
    }
}
