//
//  LinksViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/14/22.
//

import UIKit

class LinksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let webViewController = segue.destination as! WebViewController
        
        if segue.identifier == "guidelineButton" {
            let url = URL(string: "https://driving-tests.org/beginner-drivers/what-to-do-after-a-car-accident")
            webViewController.url = url
        }
        else if segue.identifier == "sayButton" {
            let url = URL(string: "https://www.cellinolaw.com/phrases-never-say-after-a-car-accident/")
            webViewController.url = url
        }
        else if segue.identifier == "insuranceButton" {
            let url = URL(string: "https://www.amfam.com/resources/articles/understanding-insurance/car-insurance-after-an-accident")
            webViewController.url = url
        }
        else if segue.identifier == "injuryButton" {
            let url = URL(string: "https://arizonapain.com/whiplash-and-back-injuries-from-car-accidents/")
            webViewController.url = url
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
