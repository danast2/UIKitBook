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
                difficulty: 3, // Средний уровень сложности по умолчанию
                createdAt: Date(), // Устанавливаем дату создания
                lastUpdated: Date() // Устанавливаем дату последнего обновления
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
        // Обновляем карточку с новыми параметрами
        deck.cards[index] = Card(
            id: currentCard.id,
            frontText: currentCard.frontText,
            backText: currentCard.backText,
            reviewDate: nextReviewDate,
            difficulty: newDifficulty,
            createdAt: currentCard.createdAt, // Оставляем дату создания неизменной
            lastUpdated: Date() // Фиксируем дату последнего обновления
        )
        
        saveChanges()
    }
    
    func updateDeck() {
        let allDecks = storageService.loadDecks()
        if let updatedDeck = allDecks.first(where: { $0.id == deck.id }) {
            self.deck = updatedDeck
            onDeckUpdated?(deck) // Уведомляем UI
        }
    }
    
    private func saveChanges() {
        var allDecks = storageService.loadDecks()
        if let index = allDecks.firstIndex(where: { $0.id == deck.id }) {
            allDecks[index] = deck
        }
        storageService.saveDecks(allDecks)
        onDeckUpdated?(deck)
    }
    
    func editCard(at index: Int, front: String, back: String) {
        guard index < deck.cards.count else { return }
        
        deck.cards[index].frontText = front
        deck.cards[index].backText = back
        saveChanges() //сохраняем изменения
    }
}
