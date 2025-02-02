// Модель колоды

import Foundation

struct Deck:Identifiable, Codable{
    let id: UUID
    var name: String
    var cards: [Card]
}
