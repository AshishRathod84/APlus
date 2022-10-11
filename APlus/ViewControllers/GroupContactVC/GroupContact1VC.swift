//
//  GroupContactVC.swift
//  MyFramework
//
//  Created by Auxano on 04/10/22.
//

import UIKit

public class GroupContact1VC: UIViewController {

    @IBOutlet weak var viewBackCreatGrp: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblCreatGroup: UILabel!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblContact: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    
    var arrGrupUserList : [allGrupUser]? = [
        allGrupUser.init(userImg: "", userName: "user1", isSelected: false, userDisName: "User 1"),
        allGrupUser.init(userImg: "", userName: "user2", isSelected: false, userDisName: "User 2"),
        allGrupUser.init(userImg: "", userName: "user3", isSelected: false, userDisName: "User 3"),
        allGrupUser.init(userImg: "", userName: "user4", isSelected: false, userDisName: "User 4"),
        allGrupUser.init(userImg: "", userName: "user5", isSelected: false, userDisName: "User 5"),
        allGrupUser.init(userImg: "", userName: "user6", isSelected: false, userDisName: "User 6"),
        allGrupUser.init(userImg: "", userName: "user7", isSelected: false, userDisName: "User 7"),
        allGrupUser.init(userImg: "", userName: "user8", isSelected: false, userDisName: "User 8"),
        allGrupUser.init(userImg: "", userName: "user9", isSelected: false, userDisName: "User 9"),
        allGrupUser.init(userImg: "", userName: "user10", isSelected: false, userDisName: "User 10"),
        allGrupUser.init(userImg: "", userName: "user11", isSelected: false, userDisName: "User 11"),
        allGrupUser.init(userImg: "", userName: "user12", isSelected: false, userDisName: "User 12"),
        allGrupUser.init(userImg: "", userName: "user13", isSelected: false, userDisName: "User 13"),
        allGrupUser.init(userImg: "", userName: "user14", isSelected: false, userDisName: "User 14"),
        allGrupUser.init(userImg: "", userName: "user15", isSelected: false, userDisName: "User 15"),
        allGrupUser.init(userImg: "", userName: "user16", isSelected: false, userDisName: "User 16"),
        allGrupUser.init(userImg: "", userName: "user17", isSelected: false, userDisName: "User 17"),
        allGrupUser.init(userImg: "", userName: "user18", isSelected: false, userDisName: "User 18"),
        allGrupUser.init(userImg: "", userName: "user19", isSelected: false, userDisName: "User 19"),
        allGrupUser.init(userImg: "", userName: "user20", isSelected: false, userDisName: "User 20")]
    
    var arrSelectedContact : [allGrupUser] = []
    
    public init() {
        super.init(nibName: "GroupContact1VC", bundle: Bundle(for: GroupContact1VC.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented GroupContactVC")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnNext.layer.cornerRadius = 5.0
        btnNext.isEnabled = false
        btnNext.backgroundColor = UIColor(red: 104/255.0, green: 162/255.0, blue: 254/255.0, alpha: 1)
        
        searchBar.delegate = self
        
        tblContact.dataSource = self
        tblContact.delegate = self
        
        let bundle = Bundle(for: GroupContact1VC.self)
        self.tblContact.register(UINib(nibName: "GrpContactTVCell", bundle: bundle), forCellReuseIdentifier: "GrpContactTVCell")
        
//        tblContact.register(UINib(nibName: "GrpContactTVCell", bundle: nil), forCellReuseIdentifier: "GrpContactTVCell")
    }
    
    @IBAction func btnBackTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNextTap(_ sender: UIButton) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc =  sb.instantiateViewController(withIdentifier: "CreateGroup1VC") as! CreateGroup1VC
//        vc.arrSelectedContact = self.arrSelectedContact
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        let myViewController = CreateGroup1VC(nibName: "CreateGroup1VC", bundle: nil)
        let myViewController = CreateGroup1VC()
        myViewController.arrSelectedContact = self.arrSelectedContact
        self.navigationController?.pushViewController(myViewController, animated: true)
        
    }
 

}

extension GroupContact1VC : UITableViewDelegate, UITableViewDataSource, SelectContactDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGrupUserList?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrpContactTVCell", for: indexPath) as! GrpContactTVCell
        cell.imgContact.layer.cornerRadius = cell.imgContact.frame.height / 2
        cell.lblSeparator.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
        cell.selectContactDelegate = self
        cell.btnSelectContact.tag = indexPath.row
        
        cell.imgContact.image = UIImage(named: "placeholder-profile-img")
        //cell.imgContact.image = UIImage(named: arrGrupUserList![indexPath.row].userImg!)
        cell.lblName.text = arrGrupUserList![indexPath.row].userDisName
        cell.btnSelectContact.isSelected = arrGrupUserList![indexPath.row].isSelected!
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GrpContactTVCell else { return }
        cell.btnSelectContact.isSelected = !(arrGrupUserList![indexPath.row].isSelected!)
        arrGrupUserList![indexPath.row].isSelected = !(arrGrupUserList![indexPath.row].isSelected!)
        
        arrSelectedContact = (arrGrupUserList?.filter{ $0.isSelected == true })!
        if arrSelectedContact.count > 1 {
            btnNext.backgroundColor = UIColor(red: 15/255.0, green: 101/255.0, blue: 158/255.0, alpha: 1)
            btnNext.isEnabled = true
        } else {
            btnNext.backgroundColor = UIColor(red: 104/255.0, green: 162/255.0, blue: 254/255.0, alpha: 1)
            btnNext.isEnabled = false
        }
    }
    
    func selectContact(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let cell = self.tblContact.cellForRow(at: indexPath) as? GrpContactTVCell else { return }
        cell.btnSelectContact.isSelected = !(arrGrupUserList![indexPath.row].isSelected!)
        arrGrupUserList![indexPath.row].isSelected = !(arrGrupUserList![indexPath.row].isSelected!)
        
        arrSelectedContact = (arrGrupUserList?.filter{ $0.isSelected == true })!
        if arrSelectedContact.count > 1 {
            btnNext.backgroundColor = UIColor(red: 15/255.0, green: 101/255.0, blue: 158/255.0, alpha: 1)
            btnNext.isEnabled = true
        } else {
            btnNext.backgroundColor = UIColor(red: 104/255.0, green: 162/255.0, blue: 254/255.0, alpha: 1)
            btnNext.isEnabled = false
        }
    }
}

extension GroupContact1VC : UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print(searchBar.text!)
    }
}
