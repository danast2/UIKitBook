//Логика карточек в колоде

import Foundation

class DeckDetailViewModel: ObservableObject {
    @Published var deck: Deck
    var onDeckUpdated: ((Deck) -> Void)? // замыкание для уведомления
    private let storageService = LocalStorageService() // Добавили сервис хранения
    
    init(deck: Deck) {
        self.deck = deck
    }
    
    func addCard(front: String, back: String) {
        let newCard = Card(
            id: UUID(),
            frontText: front,
            backText: back,
            reviewDate: Date(),
            difficulty: 3 // Средний уровень сложности по умолчанию
        )
        deck.cards.append(newCard)
        saveChanges()
        }
    
    func deleteCard(at index: Int) -> Void {
        deck.cards.remove(at: index)
        saveChanges()
    }
    
    func getCards() -> [Card] {
        return deck.cards
    }
    
    func updateCard(at index: Int, isMemorized: Bool) -> Void {
        guard index < deck.cards.count else { return }
        let currentCard = deck.cards[index]
        
        let newDifficulty = isMemorized ? max(1, currentCard.difficulty - 1) : min(5, currentCard.difficulty + 1)
        let nextReviewDate = Calendar.current.date(byAdding: .day, value: newDifficulty, to: Date()) ?? Date()
        
        //обновляем карточку
        deck.cards[index] = Card(id: currentCard.id, frontText: currentCard.frontText, backText: currentCard.backText, reviewDate: nextReviewDate, difficulty: newDifficulty)
        
        saveChanges()
    }
    
    private func saveChanges() {
        var allDecks = storageService.loadDecks()
        if let index = allDecks.firstIndex(where: { $0.id == deck.id }) {
            allDecks[index] = deck
        }
        storageService.saveDecks(allDecks)
        onDeckUpdated?(deck)
    }
}
