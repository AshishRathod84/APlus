//
//  ProfileDetailVC.swift
//  MyFramework
//
//  Created by Auxano on 30/09/22.
//

import UIKit

protocol ProfileImgDelegate {
    func setProfileImg(image : UIImage)
}

public class ProfileDetailVC: UIViewController {

    @IBOutlet weak var viewProfileTop: UIView!
    @IBOutlet weak var viewBackBtn: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var viewProfileImg: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnProfileImg: UIButton!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var imagePicker = UIImagePickerController()
    var profileImgDelegate : ProfileImgDelegate?
    
    public init() {
        super.init(nibName: "ProfileDetailVC", bundle: Bundle(for: ProfileDetailVC.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented ProfileDetailVC")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        txtUserName.delegate = self
        btnSave.layer.cornerRadius = 5 //btnSave.frame.height / 4
        
        viewProfileImg.layer.cornerRadius = viewProfileImg.frame.width / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.width / 2
        btnProfileImg.layer.cornerRadius = btnProfileImg.frame.width / 2
        
    }
    
    @IBAction func btnBackTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnProfileImgTap(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alert = UIAlertController(title: "", message: "Please select an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { alert in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallary", style: .default, handler: { alert in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { alert in
        }))
        self.present(alert, animated: true) {
        }
    }
    
    @IBAction func btnSaveTap(_ sender: UIButton) {
        if !Validations.isValidUserName(userName: txtUserName.text!) {
            // Save data
            
        } else {
            let alertWarning = UIAlertController(title: "", message: "Enter username.", preferredStyle: .alert)
            alertWarning.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { alert in
            }))
            self.present(alertWarning, animated: true)
        }
    }
}

extension ProfileDetailVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            }
            imgProfile.contentMode = .scaleAspectFill
            imgProfile.image = pickedImage
            profileImgDelegate?.setProfileImg(image: imgProfile.image!)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) {
        }
    }
}

extension ProfileDetailVC : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
