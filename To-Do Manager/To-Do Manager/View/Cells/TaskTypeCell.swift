//
//  TaskTypeCell.swift
//  To-Do Manager
//
//  Created by Даниил Асташов on 20.12.2024.
//

import UIKit

class TaskTypeCell: UITableViewCell {
    @IBOutlet var typeTitle: UILabel!
    @IBOutlet var typeDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
