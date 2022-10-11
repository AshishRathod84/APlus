//
//  UserDetailTVCell.swift
//  AgsChat
//
//  Created by MAcBook on 27/05/22.
//

import UIKit

class UserDetailTVCell: UITableViewCell {

    @IBOutlet weak var viewProfileImg: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewMsgDetail: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMsgDateTime: UILabel!
    @IBOutlet weak var lblLastMsg: UILabel!
    @IBOutlet weak var lblUnreadMsgCount: UILabel!
    @IBOutlet weak var lblSeparator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblUnreadMsgCount.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
