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

    var game = Game(startValue: 1, endValue: 50, rounds: 5)!

    
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
        versionLabel.text = "version 1.1"
        //добавляем метку в родительский view
        self.view.addSubview(versionLabel)
    }
    //updates
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
            //создаем новую игру
            game.restartGame()
            self.label.text = String(game.currentSecretValue)
        }
    
    @IBAction func checkNumber() {
        // получаем значение на слайдере
         let numSlider = Int(self.slider.value)
        game.calculateScore(with: numSlider)
        if game.isGameEnded {
            let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(game.score) очков", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            game.restartGame()
        }else{
            game.startNewRound()
        }
        self.label.text = String(game.currentSecretValue)
        
        
   }
    
}


