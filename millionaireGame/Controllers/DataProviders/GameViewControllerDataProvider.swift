//
//  GameViewControllerDataProvider.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation

final class GameViewControllerDataProvider {
    private var questions = [
        Question(question: "Какое насекомое вызвало короткое замыкание в ранней версии вычислительной машины, тем самым породив термин «компьютерный баг» («баг» в переводе с англ. «насекомое»)?",
                 answers: [1: "Мотылек",
                           2: "Таракан",
                           3: "Муха",
                           4: "Японский хрущик"],
                 validAnswer: 1,
                 weight: 100),
        Question(question: "Из каких плодов можно получить копру?",
                 answers: [1: "Ананас",
                           2: "Вишня",
                           3: "Кокос",
                           4: "Абрикос"],
                 validAnswer: 3,
                 weight: 100),

        Question(question: "Под каким названием известна единица с последующими ста нулями?",
                 answers: [1: "Мегатрон",
                           2: "Наномоль",
                           3: "Гугол",
                           4: "Гигабит"],
                 validAnswer: 3,
                 weight: 200),
        Question(question: "Какой химический элемент составляет более половины массы тела человека?",
                 answers: [1: "Углерод",
                           2: "Кальций",
                           3: "Кислород",
                           4: "Железо"],
                 validAnswer: 3,
                 weight: 200),
        Question(question: "Какую часть тела также называют «атлант»?",
                 answers: [1: "Головной мозг",
                           2: "Шестая пара ребер",
                           3: "Шейный позвонок",
                           4: "Часть плеча"],
                 validAnswer: 3,
                 weight: 300),
        Question(question: "Сколько кубиков в кубике Рубика",
                 answers: [1: "22",
                           2: "24",
                           3: "26",
                           4: "28"],
                 validAnswer: 3,
                 weight: 500),
        Question(question: "Что изобразил Юджин Сернан, последний на данный момент побывавший на Луне человек, на ее поверхности?",
                 answers: [1: "Символ мира",
                           2: "Инициалы дочери",
                           3: "Боже, храни Америку",
                           4: "Здесь был Юджин"],
                 validAnswer: 2,
                 weight: 1000),
        Question(question: "Одним из направлений какой религиозной философии является учение дзен?",
                 answers: [1: "Даосизм",
                           2: "Индуизм",
                           3: "Иудаизм",
                           4: "Буддизм"],
                 validAnswer: 4,
                 weight: 2000),
        Question(question: "Сколько морей омывают Балканский полуостров?",
                 answers: [1: "3",
                           2: "4",
                           3: "5",
                           4: "6"],
                 validAnswer: 4,
                 weight: 4000),
        Question(question: "Какая единица измерения названа в честь итальянского дворянина?",
                 answers: [1: "Паскаль",
                           2: "Ом",
                           3: "Вольт",
                           4: "Герц"],
                 validAnswer: 3,
                 weight: 4000)
    ]
    func getQuestionsCount() -> Int { questions.count }
    func getQuestion(weight: Int? = nil) -> Question? {
        let weight = weight ?? 0
        let questions = questions
            .filter { $0.weight > weight }
            .sorted(by: { $0.weight < $1.weight })
        guard let minWeight = questions.first?.weight else { return nil }
        return questions.filter { $0.weight == minWeight }.randomElement()
    }

    func getAnswers2Hide(question: Question?) -> [Int] {
        guard let question = question else { return [] }
        var answers = question.answers
        answers.removeValue(forKey: question.validAnswerId)
        guard let key = answers.randomElement()?.key else { return [] }
        answers.removeValue(forKey: key)
        return answers.map { $0.key }
    }
}
