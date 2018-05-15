//
//  AddNewHabitVC.swift
//  DailyHealth
//
//  Created by Tengzhe Li on 13/05/18.
//  Copyright © 2018 Tengzhe Li. All rights reserved.
//

import UIKit
import UserNotifications

class AddNewHabitVC: UITableViewController, UNUserNotificationCenterDelegate {

    @IBOutlet var addWholeTableView: UITableView!
    
    @IBOutlet weak var modeSwitch: UISegmentedControl!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    private var selectedTime: Date!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
            return 3
        }else{
            return 4
        }
      
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func BackToPrevious(_ sender: Any) {
        print("CheckBackButton")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveAHabit(_ sender: Any) {
        print("SaveAHabit")
        saveTitle()
        saveDescription()
        saveDate()
        saveNotificationID()
        saveState()
    }
    
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
      let a  = dateFormat.string(from: timePicker.date)
        print(a)
    }
    
    func timePickerChanged(sender: UIDatePicker) {
        print("Selected date is: \(sender.date)")
    }
    
        // save the title local memory.
        func saveTitle(){
            let AddObject = UserDefaults.standard.object(forKey: "title")
            var titleList:[String]
    
            if let tempAdd = AddObject as? [String]{
                titleList = tempAdd
                titleList.append(titleText.text!)
            }else{
                titleList = [titleText.text!]
            }
            UserDefaults.standard.set(titleList,forKey: "title")
        }
    
        // save the description local memory.
        func saveDescription(){
            let AddObject = UserDefaults.standard.object(forKey: "description")
            var descriptionList:[String]
    
            if let tempAdd = AddObject as? [String]{
                descriptionList = tempAdd
                descriptionList.append(titleText.text!)
            }else{
                descriptionList = [descriptionText.text!]
            }
            UserDefaults.standard.set(descriptionList,forKey: "description")
        }
    
    // save the date local memory.
    func saveDate(){
        let AddObject = UserDefaults.standard.object(forKey: "date")
        var dateList:[Date]
        
        if let tempAdd = AddObject as? [Date]{
            dateList = tempAdd
            dateList.append(timePicker.date)
        }else{
            dateList = [timePicker.date]
        }
        UserDefaults.standard.set(dateList,forKey: "date")
    }
   
    //send notification to system
    func notificatonSender(UniqueID:String){
        let content = UNMutableNotificationContent()
        
        content.title = "title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        let calander = Calendar(identifier: .gregorian)
        let triggerDate = calander.dateComponents([.year,.month,.day,.hour,.minute], from: timePicker.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching:triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UniqueID, content: content, trigger:trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //Save & Make a Notification
    func saveNotificationID(){
        let currentDate = Date()
        let TempID = NSUUID().uuidString
        var UniqueID:String;
        UniqueID = TempID
        
        print("UniqueID\(UniqueID)")
        let UUIDObject = UserDefaults.standard.object(forKey: "UniqueID")
        
        var UUID:[String]
        
        if let tempUUID = UUIDObject as? [String]{
            UUID = tempUUID
            UUID.append(UniqueID)
        }else{
            UUID = [UniqueID]
        }
        print("UniqueID\(UniqueID)")
        
        UserDefaults.standard.set(UUID,forKey: "UniqueID")
        if currentDate < (timePicker.date){
            notificatonSender(UniqueID: UniqueID)
        }
    }
    
    // save the title local memory.
    func saveState(){
        let StateObject = UserDefaults.standard.object(forKey: "state")
        var stateList:[Bool]
        
        if let tempState = StateObject as? [Bool]{
            stateList = tempState
            stateList.append(true)
        }else{
            stateList = [true]
        }
        UserDefaults.standard.set(stateList,forKey: "state")
    }
    
    

}
