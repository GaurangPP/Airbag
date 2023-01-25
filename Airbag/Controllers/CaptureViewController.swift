//
//  CaptureViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/23/22.
//

import UIKit
import CameraManager

class CaptureViewController: UIViewController {
    
    let cameraManager = CameraManager()
    
    var image: UIImage?
    
    var delegate: TookPhotoDelegate?
    
    var key: String?
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraManager.addPreviewLayerToView(self.cameraView) //Why giving error
        
    }
    
    
    @IBAction func didPressCapture(_ sender: Any) {
        cameraManager.capturePictureWithCompletion({ result in
            switch result {
                case .failure:
                print("Error")
                case .success(let content):
                self.image = content.asImage;
                self.delegate!.returningImage(image: self.image!, identity: self.key!)
            }
        })
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol TookPhotoDelegate {
    func returningImage(image: UIImage, identity: String)
}
