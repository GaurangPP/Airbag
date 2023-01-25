//
//  EmergencyViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/10/22.
//

import UIKit

class EmergencyViewController: UIViewController {

    
    @IBOutlet weak var emergencyCallButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPressEmergency(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://\(Constants.emergencyServicesNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
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
