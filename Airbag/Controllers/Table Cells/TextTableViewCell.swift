//
//  TextTableViewCell.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/15/22.
//

import UIKit
import CoreData

class TextTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    
    static let identifier = "TextTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TextTableViewCell", bundle: nil)
    }
    
    var gate = true
    
    @IBOutlet var field: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        field.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return gate
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { //Use this to store
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { //Or this not completely sure but this is API accurate
         
        return true
    }
    
    
    public func configure(placeHolder: String, isPhoneNumber: Bool) { //Consider adding a third parameter to make it editable or not
        
        field.placeholder = placeHolder
        if isPhoneNumber{
            field.keyboardType = .phonePad
        }
    }
    
    override func prepareForReuse() { //To clear input when cell is being reused
        
        super.prepareForReuse()
        //self.field.text = ""
    }
    
    
    
    
}
