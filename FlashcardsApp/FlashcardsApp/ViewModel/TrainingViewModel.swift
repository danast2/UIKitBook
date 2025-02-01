//Логика тренировки карточек

import Foundation

class TrainingViewModel: ObservableObject {
    @Published private(set) var currentCard: Card?
    private var deck: Deck
    private var reviewQueue: [Card] = []
    private var currentIndex = 0
    
    init(deck: Deck) {
        self.deck = deck
        self.prepareReviewQueue()
        self.loadNextCard()
    }
    
    private func prepareReviewQueue() {
        //фильтруем карточки, которые нужно повторить
        let today = Date()
        reviewQueue = deck.cards.filter { $0.reviewDate <= today}
        reviewQueue.shuffle() //перемешиваем для разнообразия
    }
    
    func loadNextCard() -> Void {
        if reviewQueue.isEmpty {
            currentCard = nil // завершение тренировки
        } else {
            currentCard = reviewQueue[currentIndex]
        }
    }
    
    func markAsRemembered() -> Void {
        guard let card = currentCard else { return }
        updateReviewDate(for: card, harder: false)
        moveToNextCard()
    }
    
    func markAsDifficult() -> Void {
        guard let card = currentCard else { return }
        updateReviewDate(for: card, harder: true)
        moveToNextCard()
    }
    
    private func updateReviewDate(for card: Card, harder: Bool){
        if let index = deck.cards.firstIndex(where: { $0.id == card.id }) {
            deck.cards[index].reviewDate = ReviewScheduler.getNextReviewDate(forDifficulty: harder ? 3 : 1)
        }
    }
    
    private func moveToNextCard(){
        currentIndex += 1
        if currentIndex >= reviewQueue.count {
            currentCard = nil //завершение тренировки
        } else {
            currentCard = reviewQueue[currentIndex]
        }
    }
    
    func hasMoreCards() -> Bool {
        return currentCard != nil
    }
    
}
