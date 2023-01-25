//
//  ReviewPhotosViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/24/22.
//

import UIKit

class ReviewPhotosViewController: UIViewController {
    
    var images = [UIImage]()
    
    var index = 0
    
    var max = 0
    
    var delegate: SendPhotosDelegate?
    
    @IBOutlet weak var photosView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if images.count != 0 {
            photosView.image = images[index]
            max = images.count
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forwardButton(_ sender: Any) {
        if images.count == 0 {
            return
        }
        if index == self.max - 1 {
            index = 0
        }
        else{
            index += 1
        }
        photosView.image = images[index]
    }
    
    @IBAction func backButton(_ sender: Any) {
        if images.count == 0 {
            return
        }
        if index == 0 {
            index = self.max - 1
        }
        else{
            index -= 1
        }
        
        photosView.image = images[index]
    }
    
    @IBAction func trashButton(_ sender: Any) {
        if images.count == 0 {
            return
        }
        images.remove(at: index) //Consider adding this to CoreData (good idea)
        self.max -= 1
        if index == max {
            index = 0
        }
        if self.max != 0 {
            photosView.image = images[index]
        }
        else {
            photosView.image = nil
        }
        
        delegate?.sendPhotos(images: self.images)
        
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

protocol SendPhotosDelegate {
    func sendPhotos(images: [UIImage])
}
