//
//  PostCell.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import UIKit

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupFromAPI(model: Post){
        postTitle.text = model.title
        leftImage.image = model.isFavorite ?? false ? UIImage(systemName: "star.fill") : UIImage(systemName: "circle.fill")
        leftImage.tintColor = model.isFavorite ?? false ? .systemYellow : .systemBlue
    }
    
    /*func setupFromCD(model: CDPost){
        postTitle.text = model.title
        
        leftImage.image = model.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "circle.fill")
        leftImage.tintColor = model.isFavorite ? .systemYellow : .systemBlue
    }*/
    
}
