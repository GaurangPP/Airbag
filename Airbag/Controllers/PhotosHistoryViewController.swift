//
//  PhotosHistoryViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/30/22.
//

import UIKit

class PhotosHistoryViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var images = [CrashImages]()
    var imagesInUI = [UIImage]()
    
    var index = 0
    
    var max = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for crashImage in images{
            var uiimage = UIImage(data: crashImage.storedImage!)
            uiimage = uiimage!.rotate(radians: .pi/2)
            imagesInUI.append(uiimage!)
        }
        
        if imagesInUI.count != 0 {
            imageView.image = imagesInUI[index]
            max = imagesInUI.count
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func rightPressed(_ sender: Any) {
        if imagesInUI.count == 0 {
            return
        }
        if index == self.max - 1 {
            index = 0
        }
        else{
            index += 1
        }
        imageView.image = imagesInUI[index]
    }
    
    
    @IBAction func leftPressed(_ sender: Any) {
        if images.count == 0 {
            return
        }
        if index == 0 {
            index = self.max - 1
        }
        else{
            index -= 1
        }
        
        imageView.image = imagesInUI[index]
    }
    
    
    @IBAction func pressedShare(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: self.imagesInUI, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToFlickr]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
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

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
    
    
    
}
