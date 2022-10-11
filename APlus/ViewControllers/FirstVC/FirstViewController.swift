//
//  FirstViewController.swift
//  MyFramework
//
//  Created by Auxano on 30/09/22.
//

import UIKit
import SocketIO

public class FirstViewController: UIViewController {

    @IBOutlet weak var viewTopChatGrp: UIView!
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var btnNewChat: UIButton!
    @IBOutlet weak var btnNewGroupChat: UIButton!
    @IBOutlet weak var btnViewUserProfile: UIButton!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userName : String = "ABC"
    var arrAllUserChat : [allChatUser]? = []
    var isNetworkAvailable : Bool = false
    
    public init() {
        super.init(nibName: "FirstViewController", bundle: Bundle(for: FirstViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented FirstViewController")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        let queue = DispatchQueue(label: "Monitor")
        //        NetworkManager.sharedInstance.monitor.start(queue: queue)
        
        //SocketChatManager.sharedInstance.establishConnection()
        
        print("view Did Load Called")
        print("view Did Load Called 1")
        
        let bundle = Bundle(for: FirstViewController.self)
        self.tblChat.register(UINib(nibName: "UserDetailTVCell", bundle: bundle), forCellReuseIdentifier: "UserDetailTVCell")

        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
        
        imgProfilePic.image = UIImage(named: "placeholder-profile-img")
        
        searchBar.delegate = self
        
        tblChat.dataSource = self
        tblChat.delegate = self
        
//        tblChat.register(UINib(nibName: "UserDetailTVCell", bundle: nil), forCellReuseIdentifier: "UserDetailTVCell")
        
        if Network.reachability.isReachable {
            isNetworkAvailable = true
        }
        //NotificationCenter.default.addObserver(self, selector: #selector(checkConnection), name: .flagsChanged, object: nil)
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.height / 2
    }
    
    @objc func checkConnection(_ notification: Notification) {
        updateUserInterface()
    }
    
    func updateUserInterface() {
        switch Network.reachability.isReachable {
        case true:
            if !self.isNetworkAvailable {
                self.isNetworkAvailable = true
                let toastMsg = ToastUtility.Builder(message: "Network available.", controller: self, keyboardActive: false)
                toastMsg.setColor(background: .green, text: .black)
                toastMsg.show()
            }
            print("Network connection available.")
            break
        case false:
            if isNetworkAvailable {
                self.isNetworkAvailable = false
                let toastMsg = ToastUtility.Builder(message: "No Network.", controller: self, keyboardActive: false)
                toastMsg.setColor(background: .red, text: .black)
                toastMsg.show()
            }
            SocketChatManager.sharedInstance.establishConnection()
            break
        }
        
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
        
    }
    
    @IBAction func btnViewUserProfileTap(_ sender: UIButton) {
        
        let myViewController = ProfileDetailVC()
        myViewController.profileImgDelegate = self
        self.navigationController?.pushViewController(myViewController, animated: true)
        
    }
    
    @IBAction func btnNewChatTap(_ sender: UIButton) {
        
        let myViewController = ContactListVC()
        self.navigationController?.pushViewController(myViewController, animated: true)
        
    }
    
    @IBAction func btnNewGroupChatTap(_ sender: UIButton) {
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc =  sb.instantiateViewController(withIdentifier: "GroupContactVC") as! GroupContactVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let myViewController = GroupContact1VC()
        self.navigationController?.pushViewController(myViewController, animated: true)
        
    }

}

extension FirstViewController : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//arrAllUserChat?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailTVCell", for: indexPath) as! UserDetailTVCell
        cell.viewProfileImg.layer.cornerRadius = cell.viewProfileImg.frame.height / 2
        cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.height / 2
        cell.lblUnreadMsgCount.layer.cornerRadius = cell.lblUnreadMsgCount.frame.height / 2
        cell.lblSeparator.backgroundColor = .gray
        
        cell.imgProfile.backgroundColor = .clear
        cell.viewProfileImg.backgroundColor = .clear
        cell.viewMsgDetail.backgroundColor = .clear
        
        //cell.imgProfile.image = UIImage(named: "placeholder-profile-img")
//        NetworkManager.sharedInstance.getData(from: URL(string: "\(arrAllUserChat![indexPath.row])")!) { data, resp, err in
//            guard let data = data, err == nil else { return }
//            DispatchQueue.main.async {
//                cell.imgProfile.image = UIImage(data: data)
//            }
//        }
//        cell.lblUserName.text = arrAllUserChat![indexPath.row].userDisName
//        cell.lblLastMsg.text = arrAllUserChat![indexPath.row].lastChatMsg
//        cell.lblMsgDateTime.text = arrAllUserChat![indexPath.row].lastMsgTime
//        if arrAllUserChat![indexPath.row].unreadMsg == "" {
//            cell.lblUnreadMsgCount.isHidden = true
//        } else {
//            cell.lblUnreadMsgCount.text = arrAllUserChat![indexPath.row].unreadMsg
//        }
        
        cell.lblUserName.text = "User 1"
        cell.lblLastMsg.text = "last msg."
        cell.lblMsgDateTime.text = "Yesterday"
        cell.lblUnreadMsgCount.text = "1"
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let chatVC = ChatVC.loadFromNib()
//        self.navigationController?.pushViewController(chatVC, animated: true)
        
        let vc = ChatVC()
         self.navigationController!.pushViewController(vc, animated: true)
        
//        self.navigationController?.pushViewController(ChatVC(), animated: true)
    
    }
}

extension FirstViewController : UISearchBarDelegate, ProfileImgDelegate {
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print(searchBar.text!)
    }
    
    func setProfileImg(image: UIImage) {
        imgProfilePic.contentMode = .scaleAspectFill
        imgProfilePic.image = image
    }
    
}


extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
}
