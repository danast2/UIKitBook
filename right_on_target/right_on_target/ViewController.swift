//
//  ViewController.swift
//  right_on_target
//
//  Created by Даниил Асташов on 30.10.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    var game: NewGame<Int>
    // Используем инициализатор `init(coder:)`
        required init?(coder: NSCoder) {
            // Инициализируем свойства перед вызовом `super.init`
            
            let gen = NewGenerator{ Int.random(in: 1...50) }
            self.game = NewGame(rounds: 5, generator: gen)
            super.init(coder: coder)  // Вызов инициализатора суперкласса
        }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         print("viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         print("viewDidDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         print("viewWillAppear")
    }
    
    override func loadView() {
        super.loadView()
        print("load view")
        
        //метка для вывода номера версии
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        //текст метки
        versionLabel.text = "version 1.3"
        //добавляем метку в родительский view
        self.view.addSubview(versionLabel)
    }
    //updates
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        //создаем новую игру
        game.restartGame()
        self.label.text = String(game.currentRound.secretValue)
        }
    
    @IBAction func checkNumber() {
        // получаем значение на слайдере
        let numSlider = Int(self.slider.value)
        game.currentRound.calculateScore(with: numSlider)
        
        // Update the total game score and reset the round score
            game.score += game.currentRound.score
            game.currentRound.score = 0
        
        if game.isGameEnded {
            let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(game.score) очков", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            game.restartGame()
        }else{
            game.startNewRound()
        }
        self.label.text = String(game.currentRound.secretValue)
   }
    
}


