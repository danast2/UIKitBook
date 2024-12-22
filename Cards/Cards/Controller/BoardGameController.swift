//
//  BoardGameController.swift
//  Cards
//
//  Created by Даниил Асташов on 22.12.2024.
//

import UIKit

class BoardGameController: UIViewController {
    // размеры карточек
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    // предельные координаты размещения карточки
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    // количество пар уникальных карточек
    var cardsPairsCounts = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
    // кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    private func getStartButtonView() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center.x = view.center.x

        // Получаем доступ к текущему окну
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let topPadding = window.safeAreaInsets.top
            button.frame.origin.y = topPadding
        }

        // Изменяем положение кнопки
        button.center.x = view.center.x

        // Настраиваем внешний вид кнопки
        button.setTitle("Начать игру", for: .normal)
        print("Window: \(String(describing: UIApplication.shared.connectedScenes.first))")
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10

        // Подключаем обработчик нажатия к текущему объекту
        button.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        return button
    }
    // игровое поле
    lazy var boardGameView = getBoardGameView()
    private func getBoardGameView() -> UIView {
     // отступ игрового поля от ближайших элементов
     let margin: CGFloat = 10

     let boardView = UIView()
     // указываем координаты
     // x
     boardView.frame.origin.x = margin
     // y
     let window = UIApplication.shared.windows[0]
     let topPadding = window.safeAreaInsets.top
     boardView.frame.origin.y = topPadding + startButtonView.frame.height +
    margin

     // рассчитываем ширину
     boardView.frame.size.width = UIScreen.main.bounds.width - margin*2
     // рассчитываем высоту
     // c учетом нижнего отступа
     let bottomPadding = window.safeAreaInsets.bottom
     boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding

     // изменяем стиль игрового поля
     boardView.layer.cornerRadius = 5
     boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)

     return boardView
    }
    // генерация массива карточек на основе данных Модели
    private func getCardsBy(modelData: [Card]) -> [UIView] {
         // хранилище для представлений карточек
         var cardViews = [UIView]()
         // фабрика карточек
         let cardViewFactory = CardViewFactory()
         // перебираем массив карточек в Модели
         for (index, modelCard) in modelData.enumerated() {
         // добавляем первый экземпляр карты
         let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
         cardOne.tag = index
         cardViews.append(cardOne)
         // добавляем второй экземпляр карты
         let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
         cardTwo.tag = index
         cardViews.append(cardTwo)
     }
     // добавляем всем картам обработчик переворота
     for card in cardViews {
         (card as! FlippableView).flipCompletionHandler = { flippedCard in
             // переносим карточку вверх иерархии
             flippedCard.superview?.bringSubviewToFront(flippedCard)
         }
     }
        return cardViews
    }
    // игральные карточки
    var cardViews = [UIView]()
    private func placeCardsOnBoard(_ cards: [UIView]) {
        // удаляем все имеющиеся на игровом поле карточки
        for card in cardViews {
            card.removeFromSuperview()
        }
        cardViews = cards
        // перебираем карточки
        for card in cardViews {
            // для каждой карточки генерируем случайные координаты
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y:
            randomYCoordinate)
            // размещаем карточку на игровом поле
            boardGameView.addSubview(card)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        }
    override func loadView() {
        super.loadView()

        // добавляем кнопку на сцену
        view.addSubview(startButtonView)
        // добавляем игровое поле на сцену
        view.addSubview(boardGameView)
    }
    
    @objc func startGame(_ sender: UIButton) {
        //print("Window: \(UIApplication.shared.connectedScenes.first)")
        print("button was pressed")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
