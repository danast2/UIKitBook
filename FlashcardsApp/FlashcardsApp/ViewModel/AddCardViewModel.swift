

import UIKit

import Foundation

class AddCardViewModel: ObservableObject {
    private var deck: Deck
    private let storageService = LocalStorageService() // Для сохранения
    
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
            difficulty: 3, // Средний уровень сложности по умолчанию
            createdAt: Date(), // Устанавливаем дату создания
            lastUpdated: Date(), // Устанавливаем дату последнего обновления
            imagePath: imagePath // Используем путь вместо imageData
        )
        
        deck.cards.append(newCard)
        saveChanges()
    }

    
    private func saveChanges() {
        var allDecks = storageService.loadDecks()
        if let index = allDecks.firstIndex(where: { $0.id == deck.id }) {
            allDecks[index] = deck
        }
        storageService.saveDecks(allDecks)
    }
}
