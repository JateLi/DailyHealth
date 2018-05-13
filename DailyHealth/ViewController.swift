//
//  ViewController.swift
//  DailyHealth
//
//  Created by Tengzhe Li on 11/05/18.
//  Copyright © 2018 Tengzhe Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var MainTableView: UITableView!
    
    @IBOutlet weak var addNewhabit: UIBarButtonItem!
    
    var exampleList = ["PlayFPS","DrinkWater","EatPills","CleanYourRoom"]
    var timeList = ["12","11","22","33"]
    var descriptionOfHabit = ["nope","Okdokey","ssssss","joopjoop"]
    //date list?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        
        cell.NameOfHabit.text = exampleList[indexPath.row]
        cell.descriptionOfHabit.text = descriptionOfHabit[indexPath.row]
        cell.StartTime.text = timeList[indexPath.row]
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

    @IBAction func AddNew(_ sender: Any) {
      self.performSegue(withIdentifier: "ToAddNewHabit", sender: nil)
    }

    
}

