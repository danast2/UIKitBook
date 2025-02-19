import XCTest
@testable import FlashcardsApp

final class TrainingViewModelTests: XCTestCase {
    
    var viewModel: TrainingViewModel!
    var deck: Deck!

    override func setUp() {
        super.setUp()
        
        let card1 = Card(id: UUID(), frontText: "Front1", backText: "Back1", reviewDate: Date.distantPast, difficulty: 1, createdAt: Date(), lastUpdated: Date())
        let card2 = Card(id: UUID(), frontText: "Front2", backText: "Back2", reviewDate: Date.distantPast, difficulty: 2, createdAt: Date(), lastUpdated: Date())

        deck = Deck(id: UUID(), name: "Training Deck", cards: [card1, card2])
        viewModel = TrainingViewModel(deck: deck)
    }

    override func tearDown() {
        viewModel = nil
        deck = nil
        super.tearDown()
    }

    /// Проверяем, что в тренировке есть карточки
    func testTrainingStartsWithCards() {
        XCTAssertTrue(viewModel.hasTrainingCards, "В тренировке должны быть карточки")
    }

    /// Проверяем, что карточка меняется при вызове nextCard()
    func testNextCardUpdatesCurrentCard() {
        let firstCard = viewModel.getCurrentCard()
        viewModel.nextCard()
        let nextCard = viewModel.getCurrentCard()
        
        XCTAssertNotEqual(firstCard?.id, nextCard?.id, "Текущая карточка должна измениться после вызова nextCard()")
    }

    /// Проверяем, что сложность карточки увеличивается при `markAsUnknown()`
    func testMarkingCardAsDifficultIncreasesDifficulty() {
        let initialCard = viewModel.getCurrentCard()!
        let initialDifficulty = initialCard.difficulty

        viewModel.markAsUnknown() // Это аналог "трудная карточка"

        let updatedCard = viewModel.getCurrentCard()!
        XCTAssertEqual(updatedCard.difficulty, min(5, initialDifficulty + 1), "Сложность карточки должна увеличиться")
    }

    /// Проверяем, что сложность уменьшается, если карточка запомнена (`markAsKnown()`)
    func testMarkingCardAsKnownDecreasesDifficulty() {
        let initialCard = viewModel.getCurrentCard()!
        let initialDifficulty = initialCard.difficulty

        viewModel.markAsKnown() // Карточка помечается как "запомнена"

        let updatedCard = viewModel.getCurrentCard()!
        XCTAssertEqual(updatedCard.difficulty, max(1, initialDifficulty - 1), "Сложность карточки должна уменьшиться")
    }

    /// Проверяем, что тренировка завершается, если карточки кончились
    func testTrainingFinishesWhenNoCardsLeft() {
        viewModel.nextCard()
        viewModel.nextCard() // Переключаемся на последнюю карточку
        viewModel.nextCard() // Попытка перейти дальше

        XCTAssertTrue(viewModel.isTrainingFinished, "Тренировка должна завершиться, когда карточки кончатся")
    }
}

