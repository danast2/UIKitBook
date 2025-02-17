import XCTest
@testable import FlashcardsApp

final class DeckTests: XCTestCase {
    
    var deck: Deck!
    
    override func setUp() {
        super.setUp()
        deck = Deck(id: UUID(), name: "Test Deck", cards: [])
    }

    override func tearDown() {
        deck = nil
        super.tearDown()
    }
    
    func testDeckInitialization() {
        XCTAssertNotNil(deck, "Колода должна создаваться")
        XCTAssertEqual(deck.name, "Test Deck", "Название колоды должно совпадать")
    }
    
    func testAddingCard() {
        let card = Card(frontText: "New", backText: "Новая", reviewDate: Date(), difficulty: 1, createdAt: Date(), lastUpdated: Date())
        let initialCount = deck.cards.count

        deck.cards.append(card)

        XCTAssertEqual(deck.cards.count, initialCount + 1, "Количество карт должно увеличиться")
    }
}

