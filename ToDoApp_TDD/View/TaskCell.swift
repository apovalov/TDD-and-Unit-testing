//
//  TaskCell.swift
//  ToDoApp_TDD
//
//  Created by Macbook on 04.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(withTask task: Task, done: Bool = false) {
        
        if done { let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            self.titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
        } else {
            self.titleLabel.text = task.title
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yy"
            let dateString = df.string(from: task.date)
            dateLabel.text = dateString
            
            if let location = task.location {
                self.locationLabel.text = location.name
            }
        }
    }
}
