//
//  CareTaker.swift
//  millionaireGame
//
//  Created by Алексей Шинкарев on 01.03.2022.
//

import Foundation

class CareTaker<T: Codable> {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private var key: String { return String(describing: T.self) }

    func save(data: T) throws {
        let data = try encoder.encode(data)
        UserDefaults.standard.set(data, forKey: key)
    }

    func load() throws -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data,
              let decodedData = try? decoder.decode(T.self,
                                                    from: data)
        else {
            return nil
        }
        return decodedData
    }
}
