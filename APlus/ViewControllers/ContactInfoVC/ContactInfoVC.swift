//
//  ContactInfoVC.swift
//  MyFramework
//
//  Created by Auxano on 03/10/22.
//

import UIKit

public class ContactInfoVC: UIViewController {

    @IBOutlet weak var viewMainContectInfo: UIView!
    @IBOutlet weak var viewContectInfo: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblContectInfo: UILabel!
    @IBOutlet weak var viewProfilePic: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var viewDeleteChat: UIView!
    @IBOutlet weak var btnDeleteChat: UIButton!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        viewProfilePic.layer.cornerRadius = viewProfilePic.frame.width / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.width / 2
        imgProfile.backgroundColor = .cyan
    }
    
    @IBAction func btnBackTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDeleteChatTap(_ sender: UIButton) {
        print("Delete Chat Tap")
    }


}
