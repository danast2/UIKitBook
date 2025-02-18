import XCTest
@testable import FlashcardsApp

final class DeckDetailViewModelTests: XCTestCase {
    
    var viewModel: DeckDetailViewModel!
    var deck: Deck!

    override func setUp() {
        super.setUp()
        deck = Deck(id: UUID(), name: "Test Deck", cards: [])
        viewModel = DeckDetailViewModel(deck: deck)
    }

    override func tearDown() {
        viewModel = nil
        deck = nil
        super.tearDown()
    }
    
    func testDeckName() {
        XCTAssertEqual(viewModel.deck.name, "Test Deck", "Имя колоды должно быть 'Test Deck'")
    }

    func testAddingCard() {
        let initialCount = viewModel.deck.cards.count
        
        viewModel.addCard(front: "Hello", back: "Привет", image: nil)
        
        XCTAssertEqual(viewModel.deck.cards.count, initialCount + 1, "После добавления карточки их количество должно увеличиться")
        XCTAssertEqual(viewModel.deck.cards.last?.frontText, "Hello", "Последняя добавленная карточка должна быть 'Hello'")
    }

    func testDeletingCard() {
        viewModel.addCard(front: "To Delete", back: "Удалить", image: nil)
        
        let initialCount = viewModel.deck.cards.count
        let cardId = viewModel.deck.cards.last!.id
        
        viewModel.deleteCard(withId: cardId)
        
        XCTAssertEqual(viewModel.deck.cards.count, initialCount - 1, "После удаления карточки их количество должно уменьшиться")
    }

}
