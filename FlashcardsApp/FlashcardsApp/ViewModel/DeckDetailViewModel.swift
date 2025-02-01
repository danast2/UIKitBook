//Логика карточек в колоде

import Foundation

class DeckDetailViewModel: ObservableObject {
    @Published var deck: Deck
    
    init(deck: Deck) {
        self.deck = deck
    }
    
    func addCard(front: String, back: String) -> Void {
        let newCard = Card(id: UUID(), frontText: front, backText: back, reviewDate: Date(), difficulty: 3)
        deck.cards.append(newCard)
    }
    
    func deleteCard(at index: Int) -> Void {
        deck.cards.remove(at: index)
    }
    
    func getCards() -> [Card] {
        return deck.cards
    }
}
