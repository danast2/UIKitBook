//Логика карточек в колоде

import Foundation

class DeckDetailViewModel: ObservableObject {
    @Published var deck: Deck
    var onDeckUpdated: ((Deck) -> Void)? // замыкание для уведомления
    
    
    init(deck: Deck) {
        self.deck = deck
    }
    
    func addCard(front: String, back: String) -> Void {
        let newCard = Card(id: UUID(), frontText: front, backText: back, reviewDate: Date(), difficulty: 3)
        deck.cards.append(newCard)
        onDeckUpdated?(deck) // уведомляем о том, что колода обновилась
    }
    
    func deleteCard(at index: Int) -> Void {
        deck.cards.remove(at: index)
        onDeckUpdated?(deck) //уведомляем о том, что колода обновилась
    }
    
    func getCards() -> [Card] {
        return deck.cards
    }
}
