import Foundation
import UIKit

class DeckDetailViewModel: ObservableObject {
    @Published var deck: Deck
    var onDeckUpdated: ((Deck) -> Void)?
    private let storageService = LocalStorageService()
    var onDeckDeleted: (() -> Void)?

    init(deck: Deck) {
        self.deck = deck
    }

    func addCard(front: String, back: String, image: UIImage?) {
        let imagePath = image != nil ? storageService.saveImage(image!) : nil

        let newCard = Card(
            id: UUID(),
            frontText: front,
            backText: back,
            reviewDate: Date(),
            difficulty: 3,
            createdAt: Date(),
            lastUpdated: Date(),
            imagePath: imagePath // Сохраняем только путь
        )
        deck.cards.append(newCard)
        saveChanges()
    }

    func deleteDeck() {
        // Удаляем все изображения карточек этой колоды
        for card in deck.cards {
            if let imagePath = card.imagePath {
                storageService.deleteImage(at: imagePath)
            }
        }

        var allDecks = storageService.loadDecks()
        allDecks.removeAll { $0.id == deck.id }
        storageService.saveDecks(allDecks)

        DispatchQueue.main.async {
            self.onDeckDeleted?()
        }
    }

    func deleteCard(withId cardId: UUID) {
        if let index = deck.cards.firstIndex(where: { $0.id == cardId }) {
            if let imagePath = deck.cards[index].imagePath {
                storageService.deleteImage(at: imagePath) // Удаляем изображение карточки
            }
            deck.cards.remove(at: index)
            saveChanges()
        }
    }

    func updateCard(at index: Int, front: String, back: String, image: UIImage?) {
        guard index < deck.cards.count else { return }

        let imagePath = image != nil ? storageService.saveImage(image!) : deck.cards[index].imagePath

        deck.cards[index].frontText = front
        deck.cards[index].backText = back
        deck.cards[index].imagePath = imagePath
        deck.cards[index].lastUpdated = Date()

        saveChanges()
    }
    func updateDeck() {
        let allDecks = storageService.loadDecks()
        if let updatedDeck = allDecks.first(where: { $0.id == deck.id }) {
            self.deck = updatedDeck
            onDeckUpdated?(deck) // Уведомляем UI
        }
    }
    
    func getCards() -> [Card] {
        return deck.cards
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

