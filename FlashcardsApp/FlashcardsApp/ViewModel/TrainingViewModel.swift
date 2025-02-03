import Foundation
import UIKit

class TrainingViewModel: ObservableObject {
    private var deck: Deck
    private var currentIndex: Int = 0
    private var trainingCards: [Card] = []
    private let storageService = LocalStorageService()

    
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
        // Логируем карточки
        for card in trainingCards {
            if let imagePath = card.imagePath, let image = LocalStorageService.loadImage(from: imagePath) {
                print("Загружено изображение для карточки: \(card.frontText)")
            } else {
                print("Нет изображения для карточки: \(card.frontText)")
            }
        }
    }
    
    private func saveChanges() {
        var allDecks = storageService.loadDecks()
        if let index = allDecks.firstIndex(where: { $0.id == deck.id }) {
            allDecks[index] = deck
        }
        storageService.saveDecks(allDecks)
    }

    
    func getCurrentCard() -> Card? {
        let card = trainingCards.isEmpty ? nil : trainingCards[currentIndex]
        print("Текущая карточка: \(String(describing: card?.frontText))") // Логируем карточку
        return card
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

        deck.cards[index] = Card(
            id: card.id,
            frontText: card.frontText,
            backText: card.backText,
            reviewDate: nextReviewDate,
            difficulty: newDifficulty,
            createdAt: card.createdAt,
            lastUpdated: Date()
        )

        saveChanges() //  Сохранение после обновления
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

