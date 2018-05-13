//
//  ViewController.swift
//  DailyHealth
//
//  Created by Tengzhe Li on 11/05/18.
//  Copyright © 2018 Tengzhe Li. All rights reserved.
//

import UIKit
var titleList :[String] = []
var descriptionOfHabit :[String] = []
var timeList :[Date] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var MainTableView: UITableView!
    
    @IBOutlet weak var addNewhabit: UIBarButtonItem!
    

    //date list?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(titleList.count)
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        
        cell.NameOfHabit.text = titleList[indexPath.row]
        cell.descriptionOfHabit.text = descriptionOfHabit[indexPath.row]
      
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
            print("Remove cell")
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

        let titleObject = UserDefaults.standard.object(forKey: "title")
        if (titleObject as? [String]) != nil{
            titleList = titleObject as! [String]
            print(titleObject ?? 0)
        }
        print(titleList)

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

    
}

