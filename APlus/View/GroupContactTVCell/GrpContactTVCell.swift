//
//  GrpContactTVCell.swift
//  AgsChat
//
//  Created by MAcBook on 28/05/22.
//

import UIKit

protocol SelectContactDelegate {
    func selectContact(sender : UIButton)
}

class GrpContactTVCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSeparator: UILabel!
    @IBOutlet weak var btnSelectContact: UIButton!
    
    var selectContactDelegate : SelectContactDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSelectContactTap(_ sender: UIButton) {
        selectContactDelegate?.selectContact(sender: sender)
    }
}
