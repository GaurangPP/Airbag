//
//  MyInfoTabViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/16/22.
//

import UIKit

class MyInfoTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var userContact: [UserContact]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        table.register(LabelTableViewCell.nib(), forCellReuseIdentifier: LabelTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        fetchContact()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Personal Information"
            return customCell
        }
        else if indexPath.row == 1 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Your Name", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .words
            customCell.field.autocorrectionType = .no
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].name
                }
            }
            return customCell
        }
        else if indexPath.row == 2 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Your Phone Number", isPhoneNumber: false)
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].number
                }
            }
            return customCell
        }
        else if indexPath.row == 3 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Your Address", isPhoneNumber: false)
            customCell.field.autocorrectionType = .no
            customCell.field.autocapitalizationType = .sentences
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].address
                }
            }
            return customCell
        }
        else if indexPath.row == 4 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "License Information"
            return customCell
        }
        else if indexPath.row == 5 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Driver License Number", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].licenseNumber
                }
            }
            return customCell
        }
        else if indexPath.row == 6 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "License Plate Number", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].plateNumber
                }
            }
            return customCell
        }
        else if indexPath.row == 7 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Vehicle Identification Number (VIN)", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].vinNumber
                }
            }
            return customCell
        }
        else if indexPath.row == 8 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Insurance Information"
            return customCell
        }
        else if indexPath.row == 9 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Insurance Carrier", isPhoneNumber: false)
            customCell.field.autocorrectionType = .no
            customCell.field.autocapitalizationType = .sentences
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].insuranceCarrier
                }
            }
            return customCell
        }
        else {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Policy Number", isPhoneNumber: false)
            if let myUserContact = userContact {
                if myUserContact.count != 0{
                    customCell.field.text = myUserContact[0].policyNumber
                }
            }
            return customCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    @IBAction func pressedSaveButton(_ sender: Any) {
        
        if self.userContact?.count != 0{
            if let previousData = self.userContact?[0] {
                self.context.delete(previousData)
                do{
                    try self.context.save()
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        let name = (table.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextTableViewCell).field.text
        let number = (table.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextTableViewCell).field.text
        let address = (table.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextTableViewCell).field.text
        let licenseNumber = (table.cellForRow(at: IndexPath(row: 5, section: 0)) as! TextTableViewCell).field.text
        let plateNumber = (table.cellForRow(at: IndexPath(row: 6, section: 0)) as! TextTableViewCell).field.text
        let vinNumber = (table.cellForRow(at: IndexPath(row: 7, section: 0)) as! TextTableViewCell).field.text
        let insuranceCarrier = (table.cellForRow(at: IndexPath(row: 9, section: 0)) as! TextTableViewCell).field.text
        let policyNumber = (table.cellForRow(at: IndexPath(row: 10, section: 0)) as! TextTableViewCell).field.text
        
        let newContact = UserContact(context: self.context)
        newContact.name = name
        newContact.number = number
        newContact.address = address
        newContact.licenseNumber = licenseNumber
        newContact.plateNumber = plateNumber
        newContact.vinNumber = vinNumber
        newContact.insuranceCarrier = insuranceCarrier
        newContact.policyNumber = policyNumber
        newContact.user = true
        
        do {
            try self.context.save() //Saving the data
        }
        catch{
            print(error.localizedDescription)
        }
        
        fetchContact()
        
    }
    
    func fetchContact(){
        do {
            self.userContact = try context.fetch(UserContact.fetchRequest())
            
            if userContact != nil{
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        }
        catch {
            print(error.localizedDescription)
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
