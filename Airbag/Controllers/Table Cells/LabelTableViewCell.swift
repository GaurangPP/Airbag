//
//  LabelTableViewCell.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/22/22.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    
    static let identifier = "LabelTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "LabelTableViewCell", bundle: nil)
    }
    
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
