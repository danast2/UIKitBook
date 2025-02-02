import Foundation

class TrainingViewModel: ObservableObject {
    private var deck: Deck
    private var currentIndex: Int = 0
    private var trainingCards: [Card] = []
    
    var onTrainingEnd: (() -> Void)?
    var isTrainingFinished: Bool = false

    
    //геттер для получения trainingCards
    var hasTrainingCards: Bool {
        return !trainingCards.isEmpty
    }
    
    
    init(deck: Deck) {
        self.deck = deck
        prepareTrainingCards() // ВЫЗЫВАЕМ этот метод при инициализации
    }
    
    private func prepareTrainingCards() {
        // Фильтруем карточки: показываем те, у которых reviewDate <= текущая дата
        let now = Date()
        trainingCards = deck.cards.filter { $0.reviewDate <= now }
        
        // Если все карточки в будущем, берем все (чтобы не было пустого экрана)
        if trainingCards.isEmpty {
            trainingCards = deck.cards
        }
        
        trainingCards.shuffle() // Перемешиваем для разнообразия
    }
    
    func getCurrentCard() -> Card? {
        return trainingCards.isEmpty ? nil : trainingCards[currentIndex]
    }
    
    
    func markAsKnown() {
        guard !trainingCards.isEmpty else { return }

        let card = trainingCards[currentIndex]
        updateCard(card, remembered: true) // Теперь `remembered: true`
        nextCard()
    }
    
    func markAsUnknown() {
        guard !trainingCards.isEmpty else { return }

        let card = trainingCards[currentIndex]
        updateCard(card, remembered: false)
        nextCard()
    }
    
    private func updateCard(_ card: Card, remembered: Bool) {
        guard let index = deck.cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        let newDifficulty = remembered ? max(1, card.difficulty - 1) : min(5, card.difficulty + 1)
        let nextReviewDate = Calendar.current.date(byAdding: .day, value: newDifficulty, to: Date()) ?? Date()

        // Обновляем карточку в массиве
        deck.cards[index] = Card(id: card.id, frontText: card.frontText, backText: card.backText, reviewDate: nextReviewDate, difficulty: newDifficulty)
    }
    
    func nextCard() {
        if currentIndex < trainingCards.count - 1 {
            currentIndex += 1
        } else {
            endTraining()
        }
    }


    private func endTraining() {
        isTrainingFinished = true
        trainingCards.removeAll()
        onTrainingEnd?() // Уведомляем контроллер
    }

}

