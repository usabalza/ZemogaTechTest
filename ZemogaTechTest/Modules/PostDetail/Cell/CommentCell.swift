//
//  CommentCell.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import UIKit

class CommentCell: UITableViewCell {
    
    static let identifier = "CommentCell"
    
    @IBOutlet weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: Comment){
        commentLabel.text = model.body
    }
    
}
