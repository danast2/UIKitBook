import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var label: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!

    var game: NewGame<String>
    var buttons: [UIButton] = []
    var correctHex: String = ""

    // Используем инициализатор `init(coder:)`
    required init?(coder: NSCoder) {
        // Инициализируем свойства перед вызовом `super.init`
        let gen = NewGenerator {
            let hexValues = "0123456789ABCDEF"
            var color = "#"
            for _ in 0..<6 {
                color.append(hexValues.randomElement()!)
            }
            return color
        }
        self.game = NewGame(rounds: 5, generator: gen)
        super.init(coder: coder)  // Вызов инициализатора суперкласса
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [button1, button2, button3, button4] // Добавляем кнопки в массив
        game.restartGame()
        setupNewRound()
    }

    // Настройка нового раунда
    func setupNewRound() {
        // Загаданный цвет
        correctHex = game.currentRound.secretValue
        label.text = correctHex

        // Генерируем дополнительные цвета
        var hexColors: [String] = [correctHex] // Добавляем загаданный цвет
        while hexColors.count < 4 {
            let newColor = generateRandomHexColor()
            if !hexColors.contains(newColor) { // Исключаем дубликаты
                hexColors.append(newColor)
            }
        }
        hexColors.shuffle() // Перемешиваем цвета

        // Устанавливаем цвета кнопкам
        // Assign colors to buttons
        for (index, button) in buttons.enumerated() {
            let hexCode = hexColors[index]
            if let color = UIColor(hex: hexCode) {
                button.backgroundColor = color
                button.setTitle("", for: .normal)
                button.accessibilityIdentifier = hexCode // Store the hex code
            }
        }
    }

    // Генерация случайного HEX-кода
    func generateRandomHexColor() -> String {
        let hexValues = "0123456789ABCDEF"
        var color = "#"
        for _ in 0..<6 {
            color.append(hexValues.randomElement()!)
        }
        return color
    }

    // Обработка нажатия кнопок
    @IBAction func checkAccordance(_ sender: UIButton) {
        guard let selectedHex = sender.accessibilityIdentifier else { return }

        if selectedHex == correctHex {
            print("Правильный ответ!")
        } else {
            print("Неправильный ответ!")
        }

        game.currentRound.calculateScore(with: selectedHex)
        game.score += game.currentRound.score

        // Proceed to next round or end the game
        if game.isGameEnded {
            let alert = UIAlertController(
                title: "Игра окончена",
                message: "Ваш счёт: \(game.score)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default) { _ in
                self.game.restartGame()
                self.setupNewRound()
            })
            self.present(alert, animated: true, completion: nil)
        } else {
            game.startNewRound()
            setupNewRound()
        }
    }
}
