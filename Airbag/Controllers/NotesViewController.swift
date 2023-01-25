//
//  NotesViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/25/22.
//

import UIKit

class NotesViewController: UIViewController, UITextViewDelegate  {
    
    
    @IBOutlet weak var notes: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var allImages = [UIImage]()
    
    var theCrashInfo = TheCrashInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes.delegate = self
        notes.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        

        // Do any additional setup after loading the view.
    }
    
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    
    
    @IBAction func pressedSaveButton(_ sender: Any) {
        
        var crashInfo = CrashInfo(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
        let randomID = Int.random(in: 0...99999999999)
        
        
        for image in allImages {
            let crashImage = CrashImages(context: self.context)
            crashImage.storedImage = image.pngData()
            crashImage.id = Int64(randomID)
            
            do {
                try self.context.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
        crashInfo.name = theCrashInfo.name
        crashInfo.phoneNumber = theCrashInfo.phoneNumber
        crashInfo.address = theCrashInfo.address
        crashInfo.vehicleDetails = theCrashInfo.vehicleDetails
        crashInfo.licenseNumber = theCrashInfo.licenseNumber
        crashInfo.plateNumber = theCrashInfo.plateNumber
        crashInfo.vinNumber = theCrashInfo.vinNumber
        crashInfo.insuranceCarrier = theCrashInfo.insuranceCarrier
        crashInfo.policyNumber = theCrashInfo.policyNumber
        crashInfo.location = theCrashInfo.location
        crashInfo.date = theCrashInfo.date
        crashInfo.time = theCrashInfo.time
        crashInfo.notes = notes.text
        crashInfo.id = Int64(randomID)
        
        let id = CrashID(context: self.context)
        id.id = Int64(randomID)
        
        do {
            try self.context.save() //Saving the data
        }
        catch{
            print(error.localizedDescription)
        }

        
        let dialogMessage = UIAlertController(title: "Saved", message: "The accident details have been saved to the History tab", preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
             self.navigationController?.popToRootViewController(animated: true)
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
        
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

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
