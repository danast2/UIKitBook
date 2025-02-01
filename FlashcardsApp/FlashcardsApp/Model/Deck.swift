// Модель колоды

import Foundation

struct Deck:Identifiable{
    let id: UUID
    var name: String
    var cards: [Card]
}
