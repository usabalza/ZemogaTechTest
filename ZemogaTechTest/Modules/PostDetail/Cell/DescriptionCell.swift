//
//  DescriptionCell.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    static let identifier = "DescriptionCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: String?){
        descriptionLabel.text = model ?? "Empty Post"
    }
    
}
