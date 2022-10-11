//
//  OtherImgChatBubbleCell.swift
//  agsChat
//
//  Created by MAcBook on 28/06/22.
//

import UIKit

class OtherImgChatBubbleCell: UITableViewCell {

    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewImg.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
