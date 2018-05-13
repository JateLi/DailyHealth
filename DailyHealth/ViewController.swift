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
    
    var ExampleList = ["PlayFPS","DrinkWater","EatPills","CleanYourRoom"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExampleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        
        cell.NameOfHabit.text = ExampleList[indexPath.row]
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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

