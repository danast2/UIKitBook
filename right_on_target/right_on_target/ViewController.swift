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
    // загаданное число
    var number: Int = 0
    // раунд
    var round: Int = 1
    // сумма очков за раунд
    var points: Int = 0
    
    @IBAction func ShowNextScreen(){
        let viewController = SecondViewController()
        self.present(viewController, animated: true, completion: nil)
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
        versionLabel.text = "version 1.1"
        //добавляем метку в родительский view
        self.view.addSubview(versionLabel)
    }
    //updates
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        /*Но в какой именно момент происходит вызов метода viewDidLoad() и вывод
         строки на консоль? Если посмотреть внимательно, то можно заметить, что надпись выводится за несколько мгновений до того, как будет отображен интерфейс
         приложения. Это происходит по той причине, что метод viewDidLoad() вызывается до того, как сцена переходит в состояние «Отображается на экране», а
         точнее в тот момент, когда все View, из которых состоит сцена, уже загружены
         62 Глава 3. Введение в жизненный цикл View Controller
         и готовы к выводу на экран (рис. 3.4). С помощью viewDidLoad() у вас появляется возможность внести в графические элементы любые финальные корректировки перед их отображением (например, изменить текст или сменить цвет).*/
        
        // генерируем случайное число
        self.number = Int.random(in: 1...50)
        // передаем значение случайного числа в label
        self.label.text = String(self.number)
        // устанавливаем счетчик раундов на 1
    }
    
    @IBAction func checkNumber() {
        // получаем значение на слайдере
         let numSlider = Int(self.slider.value)
         // сравниваем значение с загаданным
         // и подсчитываем очки
         if numSlider > self.number {
             self.points += 50 - numSlider + self.number
         } else if numSlider < self.number {
             self.points += 50 - self.number + numSlider
         } else {
             self.points += 50
         }
     if self.round == 5 {
         // выводим информационное окно
         // с результатами игры
         let alert = UIAlertController(
         title: "Игра окончена",
         message: "Вы заработали \(self.points) очков",
         preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
         self.present(alert, animated: true, completion: nil)
         self.round = 1
         self.points = 0
     } else {
         self.round += 1
      }
          // генерируем случайное число
          self.number = Int.random(in: 1...50)
          // передаем значение случайного числа в label
          self.label.text = String(self.number)
      }
    
    //review 09.11.24
    //review 11.11.24
    //review 12.11.24
    //review 13.11.24
    //review 14.11.24
     }


