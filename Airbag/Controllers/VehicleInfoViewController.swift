//
//  VehicleInfoViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/22/22.
//

import UIKit
import CoreLocation
import MapKit

class VehicleInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, photoTableViewDelegate, CLLocationManagerDelegate, TookPhotoDelegate {
    
        
    @IBOutlet weak var table: UITableView!
    
    var coordinates: (Double, Double)?
    
    var documentImages = [UIImage]()
    
    var crashImages = [UIImage]()
    
    var crashInfo = TheCrashInfo()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        table.register(LabelTableViewCell.nib(), forCellReuseIdentifier: LabelTableViewCell.identifier)
        table.register(PhotoTableViewCell.nib(), forCellReuseIdentifier: PhotoTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestLocation()
            }
        }
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Vehicle Information"
            return customCell
        }
        else if indexPath.row == 1 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Vehicle Details (Make, Model, Year)", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .sentences
            return customCell
        }
        else if indexPath.row == 2 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Driver License Number", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            return customCell
        }
        else if indexPath.row == 3 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "License Plate Number", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            return customCell
        }
        else if indexPath.row == 4 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Vehicle Identification Number (VIN)", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .allCharacters
            customCell.field.autocorrectionType = .no
            return customCell
        }
        else if indexPath.row == 5 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Insurance Information"
            return customCell
        }
        else if indexPath.row == 6 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Insurance Carrier", isPhoneNumber: false)
            customCell.field.autocorrectionType = .no
            customCell.field.autocapitalizationType = .sentences
            return customCell
        }
        else if indexPath.row == 7 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Policy Number", isPhoneNumber: false)
            return customCell
        }
        else if indexPath.row == 8 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Location and Time"
            return customCell
        }
        
        else if indexPath.row == 9 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Location in coordinates/address", isPhoneNumber: false)
            if let theCoordinates = self.coordinates {
                customCell.field.text = "\(theCoordinates.0) \(theCoordinates.1)"
            }
            return customCell
            
        }
        
        else if indexPath.row == 10 {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let stringDate = dateFormatter.string(from: date)
            
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Date", isPhoneNumber: false)
            customCell.field.text = stringDate
            return customCell
        }
        else if indexPath.row == 11 {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let stringDate = dateFormatter.string(from: date)
            
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Time", isPhoneNumber: false)
            customCell.field.text = stringDate
            return customCell
        }
        else if indexPath.row == 12 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as! LabelTableViewCell
            customCell.label.text = "Photos of License, Registration, and Insurance"
            return customCell
        }
        else{
            let customCell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            customCell.key = "Document Photos"
            customCell.delegate = self
            return customCell
        }
    }
    
    func pressedCaptureButton(key: String) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let captureViewController = mainStoryboard.instantiateViewController(withIdentifier: "photoCapture") as! CaptureViewController
        captureViewController.delegate = self
        captureViewController.key = key
        self.present(captureViewController, animated: true, completion: nil)
    }
    
    func returningImage(image: UIImage, identity: String) {
        if identity == "Document Photos"{
            self.documentImages.append(image)
        }
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.coordinates = (locValue.latitude, locValue.longitude)
        table.reloadRows(at: [IndexPath(row: 9, section: 0)], with: .automatic)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
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


 extension VehicleInfoViewController {
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "doneCollecting" {
         
        
         let vehicleDetails = (table.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextTableViewCell).field.text
         let licenseNumber = (table.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextTableViewCell).field.text
         let plateNumber = (table.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextTableViewCell).field.text
         let vinNumber = (table.cellForRow(at: IndexPath(row: 4, section: 0)) as! TextTableViewCell).field.text
         let insuranceCarrier = (table.cellForRow(at: IndexPath(row: 6, section: 0)) as! TextTableViewCell).field.text
         let policyNumber = (table.cellForRow(at: IndexPath(row: 7, section: 0)) as! TextTableViewCell).field.text
         let location = (table.cellForRow(at: IndexPath(row: 9, section: 0)) as! TextTableViewCell).field.text
         let date = (table.cellForRow(at: IndexPath(row: 10, section: 0)) as! TextTableViewCell).field.text
         let time = (table.cellForRow(at: IndexPath(row: 11, section: 0)) as! TextTableViewCell).field.text
         
         
         self.crashInfo.vehicleDetails = vehicleDetails
         self.crashInfo.licenseNumber = licenseNumber
         self.crashInfo.plateNumber = plateNumber
         self.crashInfo.vinNumber = vinNumber
         self.crashInfo.insuranceCarrier = insuranceCarrier
         self.crashInfo.policyNumber = policyNumber
         self.crashInfo.location = location
         self.crashInfo.date = date
         self.crashInfo.time = time
            
 
        let notesViewController = segue.destination as! NotesViewController
        notesViewController.theCrashInfo = self.crashInfo
        notesViewController.allImages = self.documentImages + self.crashImages
        }
    }
 }
 
