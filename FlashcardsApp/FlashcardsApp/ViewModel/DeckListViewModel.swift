//Логика списка колод

import Foundation

class DeckListViewModel: ObservableObject {
    @Published var decks: [Deck] = []
    private let storageServices = LocalStorageService()
    
    init() {
        loadDecks()
    }
    
    func addDeck(name: String) -> Void {
        let newDeck = Deck(id: UUID(), name: name, cards: [])
        decks.append(newDeck)
        saveDecks()
    }
    
    func deleteDecks(at index: Int) {
        let deckId = decks[index].id
        decks.remove(at: index)

        var savedDecks = storageServices.loadDecks()
        savedDecks.removeAll { $0.id == deckId } // Удаление из сохранённых данных
        storageServices.saveDecks(savedDecks)
    }

    
    private func saveDecks() {
        storageServices.saveDecks(decks)
    }
    
    private func loadDecks(){
        decks = storageServices.loadDecks()
    }
}
