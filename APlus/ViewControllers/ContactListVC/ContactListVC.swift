//
//  ContactListVC.swift
//  MyFramework
//
//  Created by Auxano on 03/10/22.
//

import UIKit

public class ContactListVC: UIViewController {

    @IBOutlet weak var viewBackContact: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblContactList: UILabel!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblContact: UITableView!
    
    var arrUserList : [allUser]? = [
        allUser.init(userImg: "", userName: "user1", userDisName: "User 1"),
        allUser.init(userImg: "", userName: "user2", userDisName: "User 2"),
        allUser.init(userImg: "", userName: "user3", userDisName: "User 3"),
        allUser.init(userImg: "", userName: "user4", userDisName: "User 4"),
        allUser.init(userImg: "", userName: "user5", userDisName: "User 5"),
        allUser.init(userImg: "", userName: "user6", userDisName: "User 6"),
        allUser.init(userImg: "", userName: "user7", userDisName: "User 7"),
        allUser.init(userImg: "", userName: "user8", userDisName: "User 8"),
        allUser.init(userImg: "", userName: "user9", userDisName: "User 9"),
        allUser.init(userImg: "", userName: "user10", userDisName: "User 10"),
        allUser.init(userImg: "", userName: "user11", userDisName: "User 11"),
        allUser.init(userImg: "", userName: "user12", userDisName: "User 12"),
        allUser.init(userImg: "", userName: "user13", userDisName: "User 13"),
        allUser.init(userImg: "", userName: "user14", userDisName: "User 14"),
        allUser.init(userImg: "", userName: "user15", userDisName: "User 15")]
    
    
    public init() {
        super.init(nibName: "ContactListVC", bundle: Bundle(for: ContactListVC.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented ContactListVC")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        
        tblContact.delegate = self
        tblContact.dataSource = self
        
        let bundle = Bundle(for: ContactListVC.self)
        self.tblContact.register(UINib(nibName: "ContactTVCell", bundle: bundle), forCellReuseIdentifier: "ContactTVCell")
//        tblContact.register(UINib(nibName: "ContactTVCell", bundle: nil), forCellReuseIdentifier: "ContactTVCell")
        
    }

    @IBAction func btnBackTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}


extension ContactListVC : UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print(searchBar.text!)
    }
}

extension ContactListVC : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUserList?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTVCell", for: indexPath) as! ContactTVCell
        cell.imgContactImg.layer.cornerRadius = cell.imgContactImg.frame.height / 2
        cell.lblSeparator.backgroundColor = .gray
        
        cell.imgContactImg.image = UIImage(named: "placeholder-profile-img")
        cell.lblName.text = arrUserList![indexPath.row].userDisName!
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc =  sb.instantiateViewController(withIdentifier: "UserChatVC") as! ChatVC
//        // vc.username = User name
//        vc.userName = arrUserList![indexPath.row].userName!
//        vc.userDisName = arrUserList![indexPath.row].userDisName!
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let chatVC = ChatVC()
        chatVC.userName = arrUserList![indexPath.row].userName!
        chatVC.userDisName = arrUserList![indexPath.row].userDisName!
        self.navigationController?.pushViewController(chatVC, animated: true)
        
        
    }
}
