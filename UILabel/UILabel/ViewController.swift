import UIKit

class ViewController: UIViewController {
    
    let myLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем ширину и максимальную высоту
        let labelWidth: CGFloat = 200
        let maxLabelHeight: CGFloat = CGFloat.greatestFiniteMagnitude
        let labelX: CGFloat = (view.bounds.width - labelWidth) / 2
        let labelFrame = CGRect(x: labelX, y: 0, width: labelWidth, height: maxLabelHeight)
        
        self.myLabel.frame = labelFrame
        self.myLabel.numberOfLines = 0
        self.myLabel.lineBreakMode = .byWordWrapping
        self.myLabel.text = "ios что-то там"
        self.myLabel.adjustsFontSizeToFitWidth = true
        self.myLabel.shadowOffset = CGSize(width: 2, height: 2)
        self.myLabel.shadowColor = UIColor.lightGray
        
        self.myLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.myLabel.textAlignment = .center

        // Автоматически рассчитываем высоту метки
        self.myLabel.sizeToFit()
        self.myLabel.frame.size.width = labelWidth // Фиксируем ширину
        self.myLabel.center = self.view.center // Центрируем
        
        self.view.addSubview(myLabel)
    }
}

