//
//  ContactTVCell.swift
//  AgsChat
//
//  Created by MAcBook on 28/05/22.
//

import UIKit

class ContactTVCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgContactImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSeparator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
