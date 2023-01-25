//
//  PhotoTableViewCell.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/17/22.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    var delegate: photoTableViewDelegate?
    
    static let identifier = "PhotoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PhotoTableViewCell", bundle: nil)
    }
    
    //Add a identity variable here that you will pass into the delegate method to identify the cell type.
    var key: String?
    
    
    var image: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func photoButton(_ sender: Any) {
        if let theDelegate = delegate {
            theDelegate.pressedCaptureButton(key: self.key!)
        }
    }
    
    
    
    
    
    
}

protocol photoTableViewDelegate{
    func pressedCaptureButton(key: String)
}
