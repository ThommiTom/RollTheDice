//
//  DocumentDirectory.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 21.06.22.
//

import Foundation

extension FileManager {
    static var DocumentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func load<Item: Codable>(location: URL) -> Item? {
        do {
            let data = try Data(contentsOf: location)
            let decoded = try JSONDecoder().decode(Item.self, from: data)
            return decoded
        } catch {
            print("ERROR - reading from document directory failed - \(error.localizedDescription)")
        }
        return nil
    }
    
    func save<Item: Codable>(element: Item, location: URL) {
        do {
            let data = try JSONEncoder().encode(element)
            try data.write(to: location, options: [.atomic])
        } catch {
            print("ERROR - writing to document directory failed - \(error.localizedDescription)")
        }
    }
}
