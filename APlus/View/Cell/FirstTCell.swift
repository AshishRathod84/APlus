//
//  FirstTCell.swift
//  MyFramework
//
//  Created by Auxano on 05/10/22.
//

import UIKit
 class FirstTCell: UITableViewCell {
    
    @IBOutlet var lblTitle: UILabel!

     public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
      func setTodo(str: String) {
         self.lblTitle.text = str
     }
    
}
