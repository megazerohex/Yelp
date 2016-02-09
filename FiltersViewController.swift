//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Jamel Peralta Coss on 2/8/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate{
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    //for storing the categories data
    var categories: [[String:String]]!
    //for the switch
    var switchStates = [Int:Bool]()
    //variable for the delegate of this function
    weak var delegate: FiltersViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the catagories
        categories = yelpCategories()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        let categoriess = categories[indexPath.row]
        cell.nameLabel.text = categoriess["name"]
        
        //for implementing the switch
        cell.delegate = self
        if switchStates[indexPath.row] != nil{
            cell.onSwitch.on = switchStates[indexPath.row]!
        }
        else{
            cell.onSwitch.on = false
        }
        
        return cell
    }
    
    //method for the switch dalegate
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)
        
        switchStates[indexPath!.row] = value
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearch(sender: AnyObject) {
        var filters = [String:AnyObject]()
        
        var selectedCategories = [String]()
        for(row, isSelected) in switchStates{
            if isSelected{
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0{
            filters["categories"] = selectedCategories
        }
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func yelpCategories() -> [[String:String]]{
        return [["name": "African", "code": "african"],
        ["name": "American, New", "code": "newamerican"],
        ["name": "American, Traditional", "code": "tradamerican"],
        ["name": "Argentine", "code": "argentine"],
        ["name": "Austrian", "code": "austrian"]]
    }

}
