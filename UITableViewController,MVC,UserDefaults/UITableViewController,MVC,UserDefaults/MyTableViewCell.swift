//
//  MyTableViewCell.swift
//  UITableViewController,MVC,UserDefaults
//
//  Created by Даниил Асташов on 29.01.2025.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func refresh(_ model: Model) {
        nameLabel.text = model.name
        detailLabel.text = model.prof
    }

}
