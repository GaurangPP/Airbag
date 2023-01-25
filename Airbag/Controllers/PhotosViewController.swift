//
//  ThePhotosViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/16/22.
//

import UIKit
import CameraManager

class PhotosViewController: UIViewController {
    
    let cameraManager = CameraManager()
    
    var images = [UIImage]()
    
    @IBOutlet weak var cameraView: UIView!
    
    
    @IBOutlet weak var captureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraManager.addPreviewLayerToView(self.cameraView)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPressCapture(_ sender: Any) {
        cameraManager.capturePictureWithCompletion({ result in
            switch result {
                case .failure:
                print("Error")
                case .success(let content):
                self.images.append(content.asImage!);
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Prepare for transfer
        if segue.identifier == "seePhotos" {
            let reviewPhotosViewController = segue.destination as! ReviewPhotosViewController
            
            reviewPhotosViewController.images = self.images
            reviewPhotosViewController.delegate = self
        }
        if segue.identifier == "pushPhotos" {
            let theirInfoViewController = segue.destination as! TheirInfoViewController
            
            theirInfoViewController.crashImages = images
        }
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

extension PhotosViewController: SendPhotosDelegate {
    func sendPhotos(images: [UIImage]) {
        self.images = images
    }
    
    
}
