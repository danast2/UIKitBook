

import UIKit

import Foundation

class AddCardViewModel: ObservableObject {
    private var deck: Deck
    private let storageService = LocalStorageService() // Для сохранения
    
    init(deck: Deck) {
        self.deck = deck
    }
    
    func addCard(front: String, back: String, imagePath: String?) {
        let newCard = Card(
            id: UUID(),
            frontText: front,
            backText: back,
            reviewDate: Date(),
            difficulty: 3,
            createdAt: Date(),
            lastUpdated: Date(),
            imagePath: imagePath // Передаем путь вместо UIImage
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
