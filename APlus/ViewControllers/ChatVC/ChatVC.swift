//
//  ChatVC.swift
//  MyFramework
//
//  Created by Auxano on 30/09/22.
//

import UIKit
import AVFoundation
import AVKit

public class ChatVC: UIViewController {
    
    @IBOutlet weak var viewMainChat: UIView!
    @IBOutlet weak var viewBackUserName: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewUserInfo: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnUserInfo: UIButton!
    @IBOutlet weak var btnOption: UIButton!
    @IBOutlet weak var viewTypeMsg: UIView!
    @IBOutlet weak var txtTypeMsg: UITextField!
    @IBOutlet weak var btnAttach: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var imgChatBackground: UIImageView!
    @IBOutlet weak var constMainChatViewBottom: NSLayoutConstraint!
    @IBOutlet weak var tblUserChat: UITableView!
    
    var userName : String = "abc"
    var userDisName : String?
    var isNetworkAvailable : Bool = false
    var isKeyboardActive : Bool = false
    var arrUserChat : [userChat]? = []
    var imagePicker = UIImagePickerController()
    var arrImageExtension : [String] = ["jpg", "png", "jpeg", "gif", "svg"]
    
    var arrUserChat1 : [String : [userChat]]? = [:]     //temp
    var arrChatMsg : [chatMessage] = []                 //temp
    var keys : [String] = []                            //temp
    
    public init() {
        super.init(nibName: "ChatVC", bundle: Bundle(for: ChatVC.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented ChatVC")
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //SocketChatManager.sharedInstance.register(user: "abc")
        
        loadChatData()
        
        keys = (arrUserChat1?.keys.sorted())!
        
        btnOption.tintColor = UIColor.black
        self.btnOption.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
        registerKeyboardNotifications()
        lblUserName.text = userDisName
        
        if Network.reachability.isReachable {
            isNetworkAvailable = true
        }
        
        if #available(iOS 15.0, *) {
            tblUserChat.sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkConnection), name: .flagsChanged, object: nil)
        
        let bundle = Bundle(for: ChatVC.self)
        self.tblUserChat.register(UINib(nibName: "OwnChatBubbleCell", bundle: bundle), forCellReuseIdentifier: "OwnChatBubbleCell")
        self.tblUserChat.register(UINib(nibName: "OtherChatBubbleCell", bundle: bundle), forCellReuseIdentifier: "OtherChatBubbleCell")
        self.tblUserChat.register(UINib(nibName: "OwnImgChatBubbleCell", bundle: bundle), forCellReuseIdentifier: "OwnImgChatBubbleCell")
        self.tblUserChat.register(UINib(nibName: "OtherImgChatBubbleCell", bundle: bundle), forCellReuseIdentifier: "OtherImgChatBubbleCell")
        
       /* tblUserChat.register(UINib(nibName: "OwnChatBubbleCell", bundle: nil), forCellReuseIdentifier: "OwnChatBubbleCell")
        tblUserChat.register(UINib(nibName: "OtherChatBubbleCell", bundle: nil), forCellReuseIdentifier: "OtherChatBubbleCell")
        tblUserChat.register(UINib(nibName: "OwnImgChatBubbleCell", bundle: nil), forCellReuseIdentifier: "OwnImgChatBubbleCell")
        tblUserChat.register(UINib(nibName: "OtherImgChatBubbleCell", bundle: nil), forCellReuseIdentifier: "OtherImgChatBubbleCell")*/
        
    }
    
    func loadChatData() {
        arrUserChat1 = ["Jun 11, 2022" : [userChat(userName: "", msg: "Hi", msgTime: "10:10 am", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "Hey...", msgTime: "10:10 am", msgDate: "", isSend: false, isMine: true, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "group-placeholder", msgTime: "10:11 am", msgDate: "", isSend: false, isMine: true, isImage: true, isVideo: false),
                                          userChat(userName: "", msg: "How are you ?", msgTime: "11:11 am", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "fine", msgTime: "11:13 am", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "Are you there ?", msgTime: "11:20 am", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false)],
                        "Jun 12, 2022" : [userChat(userName: "", msg: "Hey", msgTime: "10:10 am", msgDate: "", isSend: false, isMine: true, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "group-placeholder", msgTime: "10:15 am", msgDate: "", isSend: false, isMine: false, isImage: true, isVideo: false),
                                          userChat(userName: "", msg: "group-placeholder", msgTime: "10:16 am", msgDate: "", isSend: false, isMine: true, isImage: true, isVideo: false),
                                          userChat(userName: "", msg: "Anything else ?", msgTime: "10:21 am", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "No", msgTime: "10:22 am", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "Hhhhhhhhhhhhhh......", msgTime: "10:23 am", msgDate: "", isSend: false, isMine: true, isImage: false, isVideo: false)],
                        "Jun 13, 2022" : [userChat(userName: "", msg: "Hey", msgTime: "9:10 pm", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "yes", msgTime: "9:12 pm", msgDate: "", isSend: false, isMine: true, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "group-placeholder", msgTime: "9:12 pm", msgDate: "", isSend: false, isMine: false, isImage: true, isVideo: false),
                                          userChat(userName: "", msg: "placeholder-profile-img", msgTime: "9:13 pm", msgDate: "", isSend: false, isMine: true, isImage: true, isVideo: false),
                                          userChat(userName: "", msg: "kkkkkkkkk...", msgTime: "9:14 pm", msgDate: "", isSend: false, isMine: false, isImage: false, isVideo: false),
                                          userChat(userName: "", msg: "group-placeholder", msgTime: "9:15 pm", msgDate: "", isSend: false, isMine: true, isImage: true, isVideo: false),
                                          userChat(userName: "", msg: "group-placeholder", msgTime: "9:15 pm", msgDate: "", isSend: false, isMine: false, isImage: true, isVideo: false)]]
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        txtTypeMsg.delegate = self
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.width / 2

        let indexPath = IndexPath(row: arrUserChat1![keys[keys.count - 1]]!.count - 1 , section: keys.count - 1)
        tblUserChat.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    @objc func checkConnection(_ notification: Notification) {
        updateUserInterface()
    }
    
    func updateUserInterface() {
        switch Network.reachability.isReachable {
        case true:
            if !self.isNetworkAvailable {
                self.isNetworkAvailable = true
                let toastMsg = ToastUtility.Builder(message: "Internet available.", controller: self, keyboardActive: isKeyboardActive)
                toastMsg.setColor(background: .green, text: .black)
                toastMsg.show()
            }
            print("Network connection available.")
            break
        case false:
            if isNetworkAvailable {
                self.isNetworkAvailable = false
                let toastMsg = ToastUtility.Builder(message: "No Internet connection.", controller: self, keyboardActive: isKeyboardActive)
                toastMsg.setColor(background: .red, text: .black)
                toastMsg.show()
            }
            SocketChatManager.sharedInstance.establishConnection()
            break
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func btnBackTap(_ sender: UIButton) {
//        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUserInfoTap(_ sender: UIButton) {
        //        let sb = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = sb.instantiateViewController(withIdentifier: "ContectInfoVC") as! ContectInfoVC
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        let contactInfoVc = ContactInfoVC.loadFromNib()
        self.navigationController?.pushViewController(contactInfoVc, animated: true)
    }
    
    @IBAction func btnOptionTap(_ sender: UIButton) {
        print("Option Tap")
    }
    
    @IBAction func btnAttachTap(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let alert = UIAlertController(title: "", message: "Please select an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { alert in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallary", style: .default, handler: { alert in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction(title: "Document", style: .default, handler: { alert in
            if #available(iOS 14.0, *) {
                self.selectFiles()
            } else {
                // Fallback on earlier versions
            }
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { alert in
        }))
        self.present(alert, animated: true) {
        }
    }
    
    @IBAction func btnSendTap(_ sender: UIButton) {
        if !Validations.isEmpty(str: txtTypeMsg.text!) {
            /*if Network.reachability.isReachable {
             if SocketChatManager.sharedInstance.socket?.status == .connected {
             SocketChatManager.sharedInstance.send(message: txtTypeMsg.text!)
             let msg : userChat = userChat(userImg: "", userName: "abc", userDisName: "ABC", msg: txtTypeMsg.text!, msgTime: Utility.currentTime(), msgDate: Utility.currentDate(), isSend: false, isMine: true)
             txtTypeMsg.text = ""
             arrUserChat?.append(msg)
             tblUserChat.reloadData()
             let indexPath = IndexPath(row: self.arrUserChat!.count-1, section: 0)
             tblUserChat.scrollToRow(at: indexPath, at: .bottom, animated: false)
             //self.view.endEditing(true)
             } else {
             let toastMsg = ToastUtility.Builder(message: "Server not connected.", controller: self, keyboardActive: isKeyboardActive)
             toastMsg.setColor(background: .red, text: .black)
             toastMsg.show()
             }
             } else {
             let toastMsg = ToastUtility.Builder(message: "No Internet connection.", controller: self, keyboardActive: isKeyboardActive)
             toastMsg.setColor(background: .red, text: .black)
             toastMsg.show()
             }   //  */
            
            //let msg : userChat = userChat(userImg: "", userName: "abc", userDisName: "ABC", msg: txtTypeMsg.text!, msgTime: Utility.currentTime(), msgDate: Utility.currentDate(), isSend: false, isMine: true)
            let msg : userChat = userChat(userName: "", msg: txtTypeMsg.text!, msgTime: Utility.currentTime(), msgDate: Utility.currentDate(), isSend: false, isMine: true, isImage: false)
            txtTypeMsg.text = ""
            //arrUserChat?.append(msg)
            arrUserChat1![keys[keys.count - 1]]?.append(msg)
            tblUserChat.reloadData()
            
            //(arrUserChat1?[keys[indexPath.section]]![indexPath.row].msg)!
            //let indexPath = IndexPath(row: self.arrUserChat1!.count-1, section: arrUserChat1!.count - 1)
            //(arrUserChat1?[keys[arrUserChat1!.count - 1]])!
            
            let indexPath = IndexPath(row: arrUserChat1![keys[keys.count - 1]]!.count - 1 , section: keys.count - 1)
            tblUserChat.scrollToRow(at: indexPath, at: .bottom, animated: false)
            //self.view.endEditing(true)
        }
    }
    
    
}


// MARK: - Textfiled Delegate
extension ChatVC : UITextFieldDelegate {
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.isKeyboardActive = true
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            constMainChatViewBottom.constant = keyboardSize.height - 35
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.isKeyboardActive = false
        constMainChatViewBottom.constant = 0
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}


// MARK: - Camera, Gallary
extension ChatVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertController(title: "", message: "Camera not available.", preferredStyle: .alert)
            alertWarning.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { alert in
            }))
            self.present(alertWarning, animated: true)
        }
    }
    
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.dismiss(animated: true) {
                //imgProfile.contentMode = .scaleAspectFill
                //imgProfile.image = pickedImage
                //profileImgDelegate?.setProfileImg(image: imgProfile.image!)
                print("Dismiss called.")
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) {
        }
    }
}


// MARK: - Select document
extension ChatVC : UIDocumentPickerDelegate, UIDocumentMenuDelegate {
    
    @available(iOS 14.0, *)
    func selectFiles() {
//        let types = UTType.types(tag: "json",
//                                 tagClass: UTTagClass.filenameExtension,
//                                 conformingTo: nil)
//        let documentPickerController = UIDocumentPickerViewController(
//                forOpeningContentTypes: types)
//        documentPickerController.delegate = self
//        self.present(documentPickerController, animated: true, completion: nil)
        
        let documentsPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "public.data"], in: .import)
        documentsPicker.delegate = self
        documentsPicker.allowsMultipleSelection = false
        documentsPicker.modalPresentationStyle = .fullScreen
        self.present(documentsPicker, animated: true, completion: nil)
        
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        //guard controller.documentPickerMode == .import, let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
//        defer {
//            DispatchQueue.main.async {
//                url.stopAccessingSecurityScopedResource()
//            }
//        }
        
//        //Need to make a new image with the jpeg data to be able to close the security resources!
//        guard let image = UIImage(contentsOfFile: url.path), let imageCopy = UIImage(data: image.jpegData(compressionQuality: 1.0)!) else { return }
//        //self.delegate?.didSelect(image: imageCopy)
//        print("Selection Done.")
        
        let url = urls.first! as URL
        if arrImageExtension.contains((url.pathExtension).lowercased()) {
            //Need to make a new image with the jpeg data to be able to close the security resources!
            //guard let image = UIImage(contentsOfFile: url.path), let imageCopy = UIImage(data: image.jpegData(compressionQuality: 1.0)!) else { return }
            
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc =  sb.instantiateViewController(withIdentifier: "ImageViewerVC") as! ImageViewerVC
//            vc.strImageName = url.path
//            //vc.imgSelectedImage = imageCopy
//            self.present(vc, animated: true)
            
//            let myViewController = ImageViewer1VC(nibName: "ImageViewer1VC", bundle: nil)
            let myViewController = ImageViewer1VC.loadFromNib()
            myViewController.strImageName = url.path
            self.present(myViewController, animated: true, completion: nil)
            
        }
        
        print(url)
        print("\n\nOther URLs")
        print(urls)
        print("\n\nurl component.")
        print(url.lastPathComponent)
        print(url.pathExtension)
        
        controller.dismiss(animated: true)
    }
    
    public func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        print("Document picked.")
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker cancel.")
    }
}

// MARK: - TableView Delegate
extension ChatVC : UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return arrUserChat1?.count ?? 1
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView()//UIView(frame: CGRect.zero)
        viewHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45)
        viewHeader.backgroundColor = .clear
        let lblHeaderTitle : UILabel = UILabel()//(frame: CGRect.zero)
        lblHeaderTitle.frame = CGRect(x: 5, y: 5, width: tableView.frame.width, height: 35)
        //lblHeaderTitle.frame = CGRect(origin: CGPoint(x: 5, y: 5), size: cgsi)
        lblHeaderTitle.center = viewHeader.center
        lblHeaderTitle.text = keys[section]
        lblHeaderTitle.font = .systemFont(ofSize: 16)
        lblHeaderTitle.textAlignment = .center
        lblHeaderTitle.textColor = .black
        lblHeaderTitle.backgroundColor = .clear
        
        viewHeader.addSubview(lblHeaderTitle)

        return viewHeader
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Jun 27, 2022"
//    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arrUserChat?.count ?? 0
        return arrUserChat1?[keys[section]]?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (arrUserChat1?[keys[indexPath.section]]![indexPath.row].isMine)! {
            if (arrUserChat1?[keys[indexPath.section]]![indexPath.row].isImage)! {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OwnImgChatBubbleCell", for: indexPath) as! OwnImgChatBubbleCell
                
                //cell.img.image = arrUserChat1?[keys[indexPath.section]]![indexPath.row].img
                cell.img.image = UIImage(named: (arrUserChat1?[keys[indexPath.section]]![indexPath.row].msg)!)
                cell.lblTime.text = arrUserChat1?[keys[indexPath.section]]![indexPath.row].msgTime
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OwnChatBubbleCell", for: indexPath) as! OwnChatBubbleCell
                
                cell.lblMsg.text = arrUserChat1?[keys[indexPath.section]]![indexPath.row].msg
                cell.lblTime.text = arrUserChat1?[keys[indexPath.section]]![indexPath.row].msgTime
                
                return cell
            }
        } else {
            if (arrUserChat1?[keys[indexPath.section]]![indexPath.row].isImage)! {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OtherImgChatBubbleCell", for: indexPath) as! OtherImgChatBubbleCell
                
                //cell.img.image = UIImage(named: "")
                cell.img.image = UIImage(named: (arrUserChat1?[keys[indexPath.section]]![indexPath.row].msg)!)
                cell.lblTime.text = arrUserChat1?[keys[indexPath.section]]![indexPath.row].msgTime
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OtherChatBubbleCell", for: indexPath) as! OtherChatBubbleCell
                
                cell.lblMsg.text = (arrUserChat1?[keys[indexPath.section]]![indexPath.row].msg)!
                cell.lblTime.text = arrUserChat1?[keys[indexPath.section]]![indexPath.row].msgTime
                
                return cell
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (arrUserChat1?[keys[indexPath.section]]![indexPath.row].isImage)! {
           /* let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc =  sb.instantiateViewController(withIdentifier: "ImageViewerVC") as! ImageViewerVC
            let vc =  sb.instantiateViewController(withIdentifier: "ImageViewer1VC") as! ImageViewer1VC
            vc.strImageName = arrUserChat1?[keys[indexPath.section]]![indexPath.row].msg
            //self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true)*/
            
            let vc = ImageViewer1VC()
            vc.strImageName = arrUserChat1?[keys[indexPath.section]]![indexPath.row].msg
            self.present(vc, animated: true)
        } else {//if (arrUserChat1?[keys[indexPath.section]]![indexPath.row].isVideo)! {
            let url : String = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
            let player = AVPlayer(url: URL(string: url)!)
            let vcPlayer = AVPlayerViewController()
            vcPlayer.player = player
            self.present(vcPlayer, animated: true, completion: nil)
        }
    }
}
