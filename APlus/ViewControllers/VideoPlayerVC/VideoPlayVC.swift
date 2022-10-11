//
//  VideoPlayVC.swift
//  MyFramework
//
//  Created by Auxano on 04/10/22.
//

import UIKit
import AVKit
import MobileCoreServices
import AVFoundation

public class VideoPlayVC: UIViewController {

    var imagePicker = UIImagePickerController()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension VideoPlayVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 1
        guard
          let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
          mediaType == (kUTTypeMovie as String),
          let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
          else { return }

        // 2
        dismiss(animated: true) {
          //3
            //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4
          let player = AVPlayer(url: url)
          let vcPlayer = AVPlayerViewController()
          vcPlayer.player = player
          self.present(vcPlayer, animated: true, completion: nil)
        }
      }
}
