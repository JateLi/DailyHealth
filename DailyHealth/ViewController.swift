//
//  ViewController.swift
//  DailyHealth
//
//  Created by Tengzhe Li on 11/05/18.
//  Copyright © 2018 Tengzhe Li. All rights reserved.
//

import UIKit
import UserNotifications

var titleList :[String] = []
var descriptionOfHabit :[String] = []
var timeList :[Date] = []
var notificationID:[String] = []
var switchButtonState: [Bool] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UNUserNotificationCenterDelegate{
    @IBOutlet weak var MainTableView: UITableView!
    
    @IBOutlet weak var addNewhabit: UIBarButtonItem!
    
     //private var filteredIndexes: [Int] = []

    //date list?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(titleList.count)
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        
        cell.NameOfHabit.text = titleList[indexPath.row]
        cell.descriptionOfHabit.text = descriptionOfHabit[indexPath.row]
       
        // Assign switches with tags for easy tracking
        cell.openSwitch.tag = indexPath.row
        cell.openSwitch.isOn = switchButtonState[indexPath.row]
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        let a  = dateFormat.string(from:timeList[indexPath.row])
        cell.StartTime.text = a
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        // Remove all information related to that row
        if editingStyle == UITableViewCellEditingStyle.delete{
            print("Remove cell\(indexPath.row)")
            let Id = notificationID[indexPath.row]
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [Id])
            findDateNeedDelete(UniqueID: Id)
           
            refreshDate()
            self.MainTableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {

        MainTableView.delegate = self
        MainTableView.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Put all local storage to local variable
        titleList  = []
        descriptionOfHabit = []
        timeList = []
        switchButtonState = []

        let titleObject = UserDefaults.standard.object(forKey: "title")
        if (titleObject as? [String]) != nil{
            titleList = titleObject as! [String]
            print(titleObject ?? 0)
        }

        let descriptionObject = UserDefaults.standard.object(forKey: "description")
        if (descriptionObject as? [String]) != nil{
            descriptionOfHabit = descriptionObject as! [String]
            print(descriptionObject ?? 0)
        }

        let dateObject = UserDefaults.standard.object(forKey: "date")
        if (dateObject as? [Date]) != nil{
            timeList = dateObject as! [Date]
            print(dateObject ?? 0)
        }
        
        let UUIDObject = UserDefaults.standard.object(forKey: "UniqueID")
        if (UUIDObject as? [String]) != nil{
            notificationID = UUIDObject as! [String]
            print(UUIDObject ?? 0)
        }
        
        let stateObject = UserDefaults.standard.object(forKey: "state")
        if (stateObject as? [Bool]) != nil{
            switchButtonState = stateObject as! [Bool]
            print(stateObject ?? 0)
        }
        
        self.MainTableView.reloadData()

    }

    @IBAction func AddNew(_ sender: Any) {
      self.performSegue(withIdentifier: "ToAddNewHabit", sender: nil)
    }
    
    func dateToString(date:Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
        let a  = dateFormat.string(from:date)
        return a
    }
    
    func findDateNeedDelete(UniqueID: String){
        for  i in (0..<notificationID.count).reversed() {
            if UniqueID==notificationID[i]{
                titleList.remove(at: i)
                descriptionOfHabit.remove(at: i)
                timeList.remove(at: i)
                notificationID.remove(at: i)
                switchButtonState.remove(at: i)
            }
        }
    }
    
    //Refresh Local storage
    public func refreshDate(){
        _ = UserDefaults.standard.object(forKey: "title")
        UserDefaults.standard.set(titleList,forKey: "title")
        
        _ = UserDefaults.standard.object(forKey: "description")
        UserDefaults.standard.set(descriptionOfHabit,forKey: "description")
        
        _ = UserDefaults.standard.object(forKey: "date")
        UserDefaults.standard.set(timeList,forKey: "date")
        
        _ = UserDefaults.standard.object(forKey: "UniqueID")
        UserDefaults.standard.set(notificationID,forKey: "UniqueID")
        
        _ = UserDefaults.standard.object(forKey: "state")
        UserDefaults.standard.set(switchButtonState,forKey: "state")
    }

    @IBAction func SwitchChanged(_ sender: UISwitch) {
        _ = sender.tag
        if(sender.isOn){
            print("On\(sender.tag)")
            switchButtonState[sender.tag] = true
            notificatonSender(UniqueID: notificationID[sender.tag], date: timeList[sender.tag])
        }else{
             print("Off\(sender.tag)")
             switchButtonState[sender.tag] = false
            let Id = notificationID[sender.tag]
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [Id])
        }
        refreshDate()
        
    }
    
    //send notification to system
    func notificatonSender(UniqueID:String, date:Date){
        let content = UNMutableNotificationContent()
        
        content.title = "title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        let calander = Calendar(identifier: .gregorian)
        let triggerDate = calander.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching:triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UniqueID, content: content, trigger:trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
}

