//
//  TheirInfoViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/19/22.
//

import UIKit

class TheirInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var crashInfo = TheCrashInfo()
    
    var crashImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        table.register(LabelTableViewCell.nib(), forCellReuseIdentifier: LabelTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Personal Information"
            return customCell
            
        }
        else if indexPath.row == 1 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Name", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .words
            customCell.field.autocorrectionType = .no
            return customCell
        }
        else if indexPath.row == 2 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Phone Number", isPhoneNumber: false)
            return customCell
        }
        else {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Address", isPhoneNumber: false)
            customCell.field.autocorrectionType = .no
            return customCell
        }
    }
    
    
    
    @IBAction func pressedNextButton(_ sender: Any) {
        
        
        //let newContact = Contact(context: self.context)
    }
    
    //Create a fetch contact method
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TheirInfoViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoToCollect" {
            
            let name = (table.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextTableViewCell).field.text
            let number = (table.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextTableViewCell).field.text
            let address = (table.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextTableViewCell).field.text
            
            self.crashInfo.name = name
            self.crashInfo.phoneNumber = number
            self.crashInfo.address = address
            
            let vehicleInfoViewController = segue.destination as! VehicleInfoViewController
            vehicleInfoViewController.crashImages = self.crashImages
            vehicleInfoViewController.crashInfo = self.crashInfo
            
        }
    }
}
