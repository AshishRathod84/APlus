//
//  ImageViewer1VC.swift
//  MyFramework
//
//  Created by Auxano on 30/09/22.
//

import UIKit

public class ImageViewer1VC: UIViewController {

    var strImageName : String?
    var imgSelectedImage : UIImage?
    
    @IBOutlet weak var imgDisplayImg: UIImageView!
    
    public init() {
        super.init(nibName: "ImageViewerVC", bundle: Bundle(for: ImageViewer1VC.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented ImageViewerVC")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        if strImageName != "" {
            imgDisplayImg.image = UIImage(named: strImageName!)
        } else {
            imgDisplayImg.image = imgSelectedImage
        }
        
    }

}
