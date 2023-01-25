//
//  FormViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/12/22.
//

import UIKit

class MyInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var userContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        table.register(LabelTableViewCell.nib(), forCellReuseIdentifier: LabelTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        //self.userContact = try! context.fetch(Contact.fetchRequest())[0]
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Name", isPhoneNumber: false)
            customCell.field.autocapitalizationType = .words
            //customCell.field.text = self.userContact!.name ?? ""
            return customCell
        }
        else if indexPath.row == 1 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Phone Number", isPhoneNumber: true)
            //customCell.field.text = self.userContact!.number ?? ""
            return customCell
        }
        else {
            let customCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
            customCell.configure(placeHolder: "Address", isPhoneNumber: false)
            //customCell.field.text = self.userContact!.address ?? ""
            return customCell
        }
    }
    
    
    @IBAction func pressedNextButton(_ sender: Any) {
        
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
