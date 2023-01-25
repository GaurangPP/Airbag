//
//  HistoryViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/30/22.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var crashes: [CrashInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(HistoryTableViewCell.nib(), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if crashes == nil {
            return 0
        }
        else {
            return crashes!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if crashes != nil{
            let customCell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as! HistoryTableViewCell
            let currentCrash = crashes![indexPath.row]
            let id = currentCrash.id
            let date = currentCrash.date ?? "(date unavailable)"
            let time = currentCrash.time ?? "(time unavailable)"
            customCell.dateLabel.text = "Accident on \(date)"
            customCell.timeLabel.text = time
            customCell.id = id
            return customCell
        }
        else{
            let customCell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as! HistoryTableViewCell
            customCell.dateLabel.text = "Error: Data doesn't exist"
            return customCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = table.cellForRow(at: indexPath) as! HistoryTableViewCell
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let incidentViewController = storyBoard.instantiateViewController(withIdentifier: "seeIncident") as! IncidentViewController
        incidentViewController.id = cell.id ?? 0
        //self.navigationController?.pushViewController(incidentViewController, animated: true)
        self.present(incidentViewController, animated: true)
    }
    
    func fetchData(){
        do {
            self.crashes = try context.fetch(CrashInfo.fetchRequest())
            
            if self.crashes != nil{
                self.crashes?.reverse()
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = table.cellForRow(at: indexPath) as! HistoryTableViewCell
        let idToRemove = cell.id!
        
        let filter = String(idToRemove)
        let predicate = NSPredicate(format: "id = %@", filter)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CrashInfo")
        fetchRequest.predicate = predicate

        do{
            let fetchedResults = try context.fetch(fetchRequest)
            let crash = fetchedResults.first as? CrashInfo
            self.context.delete(crash!)
            do{
                try self.context.save()
            }
            catch{
                print(error.localizedDescription)
            }
            fetchData()
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
