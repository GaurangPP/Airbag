//
//  IncidentViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/30/22.
//

import UIKit
import CoreData

class IncidentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var notes: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var id: Int64 = 0
    
    var crash: CrashInfo?
    
    var crashImages: [CrashImages]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes.isEditable = false
        table.delegate = self
        table.dataSource = self
        
        table.register(LabelTableViewCell.nib(), forCellReuseIdentifier: LabelTableViewCell.identifier)
        table.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        
        let filter = String(self.id)
        let predicate = NSPredicate(format: "id = %@", filter)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CrashInfo")
        fetchRequest.predicate = predicate

        do{
            let fetchedResults = try context.fetch(fetchRequest)
            self.crash = fetchedResults.first as? CrashInfo
        }
        catch {
            print(error.localizedDescription)
        }
        if let theCrash = crash {
            self.notes.text = theCrash.notes ?? ""
        }
        // Do any additional setup after loading the view.
        
        let fetchRequestPhotos = NSFetchRequest<NSFetchRequestResult>(entityName:"CrashImages")
        fetchRequestPhotos.predicate = predicate
        
        do{
            let fetchedPhotoResults = try context.fetch(fetchRequestPhotos)
            self.crashImages = fetchedPhotoResults as? [CrashImages]
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        16
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
            customCell.gate = false
            customCell.field.autocapitalizationType = .words
            customCell.field.autocorrectionType = .no
            if let theCrash = crash {
                customCell.field.text = theCrash.name
            }
            return customCell
        }
        else if indexPath.row == 2 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Phone Number", isPhoneNumber: false)
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.phoneNumber
            }
            return customCell
        }
        else if indexPath.row == 3 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Address", isPhoneNumber: false)
            customCell.gate = false
            customCell.field.autocorrectionType = .no
            if let theCrash = crash {
                customCell.field.text = theCrash.address
            }
            return customCell
        }
        if indexPath.row == 4 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Vehicle Information"
            return customCell
        }
        else if indexPath.row == 5 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Vehicle Details (Make, Model, Year)", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .sentences
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.vehicleDetails
            }
            return customCell
        }
        else if indexPath.row == 6 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Driver License Number", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.licenseNumber
            }
            return customCell
        }
        else if indexPath.row == 7 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "License Plate Number", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.plateNumber
            }
            return customCell
        }
        else if indexPath.row == 8 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Vehicle Identification Number (VIN)", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.vinNumber
            }
            return customCell
        }
        else if indexPath.row == 9 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Insurance Information"
            return customCell
        }
        else if indexPath.row == 10 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Insurance Carrier", isPhoneNumber: false)
            customCell.field.autocorrectionType = .no
            customCell.field.autocapitalizationType = .sentences
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.insuranceCarrier
            }
            return customCell
        }
        else if indexPath.row == 11 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Policy Number", isPhoneNumber: false)
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.policyNumber
            }
            return customCell
            
        }
        else if indexPath.row == 12 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Location and Time"
            
            return customCell
        }
        
        else if indexPath.row == 13 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Location in coordinates/address", isPhoneNumber: false)
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.location
            }
            return customCell
            
        }
        
        else if indexPath.row == 14 {
            
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Date", isPhoneNumber: false)
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.date
            }
            return customCell
        }
        else {
            
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Time", isPhoneNumber: false)
            customCell.gate = false
            if let theCrash = crash {
                customCell.field.text = theCrash.time
            }
            return customCell
        }
    }
    
    
    @IBAction func pressedShare(_ sender: Any) {
        if let theCrash = self.crash {
            
            var shareString = "Accident Information"
            shareString += "\n"
            shareString += "\n"
            shareString += "\n"
            
            if let date = theCrash.date {
                shareString += "An accident occured on \(date)"
                if let time = theCrash.time {
                    shareString += " at \(time)"
                }
                shareString += "\n"
            }
            if let location = theCrash.location {
                shareString += "The accident location: \(location)"
                shareString += "\n"
                shareString += "\n"
            }
            shareString += "Other Party Information"
            shareString += "\n"
            shareString += "\n"
            shareString += "---Personal Info---"
            shareString += "\n"
            
            if let name = theCrash.name {
                shareString += "Name: \(name)"
                shareString += "\n"
            }
            if let phoneNumber = theCrash.phoneNumber{
                shareString += "Phone Number: \(phoneNumber)"
                shareString += "\n"
            }
            if let address = theCrash.address{
                shareString += "Address: \(address)"
                shareString += "\n"
            }

            shareString += "\n"
            shareString += "---Vehicle Info---"
            shareString += "\n"
            
            if let vehicleDetails = theCrash.vehicleDetails {
                shareString += "Vehicle Details: \(vehicleDetails)"
                shareString += "\n"
            }
            if let licenseNumber = theCrash.licenseNumber{
                shareString += "Driver License Number: \(licenseNumber)"
                shareString += "\n"
            }
            if let plateNumber = theCrash.plateNumber{
                shareString += "License Plate Number: \(plateNumber)"
                shareString += "\n"
            }
            if let vinNumber = theCrash.vinNumber{
                shareString += "VIN Number: \(vinNumber)"
                shareString += "\n"
            }
            
            shareString += "\n"
            shareString += "---Insurance Info---"
            shareString += "\n"
            
            if let insuranceCarrier = theCrash.insuranceCarrier{
                shareString += "Insurance Carrier: \(insuranceCarrier)"
                shareString += "\n"
            }
            if let policyNumber = theCrash.policyNumber{
                shareString += "Policy Number: \(policyNumber)"
                shareString += "\n"
            }
            
            if let notes = theCrash.notes {
                shareString += "\n"
                shareString += "---Notes---"
                shareString += "\n"
                shareString += notes
            }
            
            
                    
            // set up activity view controller
            let textToShare = [ shareString ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToFlickr]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seePics" {
            let photosHistoryViewController = segue.destination as! PhotosHistoryViewController
            if let theCrashImages = self.crashImages{
                photosHistoryViewController.images = theCrashImages
            }
        }
    }

}
