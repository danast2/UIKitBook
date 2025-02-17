import XCTest
@testable import FlashcardsApp

final class DeckListViewModelTests: XCTestCase {
    
    var viewModel: DeckListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = DeckListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testAddingDeck() {
        let initialCount = viewModel.decks.count
        viewModel.addDeck(name: "New Deck")

        XCTAssertEqual(viewModel.decks.count, initialCount + 1, "Количество колод должно увеличиться")
        XCTAssertEqual(viewModel.decks.last?.name, "New Deck", "Имя новой колоды должно быть 'New Deck'")
    }
}
