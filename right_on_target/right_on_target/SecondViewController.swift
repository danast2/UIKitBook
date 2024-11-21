//
//  SecondViewController.swift
//  right_on_target
//
//  Created by Даниил Асташов on 07.11.2024.
//

import UIKit

class SecondViewController: UIViewController {
    //@IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    var game: NewGame<String>
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
            //let gen = NewGenerator{ Int.random(in: 1...50) }
            self.game = NewGame(rounds: 5, generator: gen)
            super.init(coder: coder)  // Вызов инициализатора суперкласса
        }
    override func loadView() {
         super.loadView()
         print("loadView SecondViewController")
        
        //метка для вывода номера версии
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        //текст метки
        versionLabel.text = "version 1.1"
        //добавляем метку в родительский view
        self.view.addSubview(versionLabel)
     }
     override func viewDidLoad() {
         super.viewDidLoad()
         print("viewDidLoad SecondViewController")
         
         game.restartGame()
         self.label.text = String(game.currentRound.secretValue)
     }

     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         print("viewWillAppear SecondViewController")
     }

     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         print("viewDidAppear SecondViewController")
     }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         print("viewWillDisappear SecondViewController")
     }

     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         print("viewDidDisappear SecondViewController")
     }
    
    @IBAction func checkAccordance(_ sender: UIButton){
        //print("Кнопка нажата: \(sender.currentTitle ?? "Без имени")")
        if sender == button1 {
                print("Нажата кнопка 1")
            } else if sender == button2 {
                print("Нажата кнопка 2")
            } else if sender == button3 {
                print("Нажата кнопка 3")
            } else if sender == button4 {
                print("Нажата кнопка 4")
            }
        //review 21.11.24
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
