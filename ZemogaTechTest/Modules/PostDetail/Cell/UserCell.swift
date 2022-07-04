//
//  UserCell.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let identifier = "UserCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: User?){
        nameLabel.text = model?.name ?? "No Name"
        emailLabel.text = model?.email ?? "No Email"
        phoneLabel.text = model?.phone ?? "No Phone"
        websiteLabel.text = model?.website ?? "No Website"
    }
    
}
