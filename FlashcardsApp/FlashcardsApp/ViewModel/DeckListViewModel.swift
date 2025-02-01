//Логика списка колод

import Foundation

class DeckListViewModel: ObservableObject {
    @Published var decks: [Deck] = []
    
    func addDeck(name: String) -> Void {
        let newDeck = Deck(id: UUID(), name: name, cards: [])
        decks.append(newDeck)
    }
}
