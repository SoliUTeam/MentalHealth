//
//  InspiringQuote.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/29/24.
//

import Foundation

struct QuoteData: Codable {
    let quoteData: [Quote]
}

struct Quote: Codable {
    let quote: String
    let name: String
}

func getRandomQuote() -> [String: String]? {
    guard let fileURL = Bundle.main.url(forResource: "InspiringQuote", withExtension: "json") else {
        print("JSON file not found")
        return nil
    }

    do {
        let jsonData = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let quoteData = try decoder.decode(QuoteData.self, from: jsonData)

        guard !quoteData.quoteData.isEmpty else {
            print("quoteData array is empty")
            return nil
        }
        let randomIndex = Int.random(in: 0..<quoteData.quoteData.count)
        let randomQuote = quoteData.quoteData[randomIndex].quote
        let randomQuoteName = quoteData.quoteData[randomIndex].name
        return [randomQuote: randomQuoteName]
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}
