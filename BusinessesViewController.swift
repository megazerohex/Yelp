//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Jamel Peralta Coss on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchResultsUpdating {
    //Storing the data
    var businesses: [Business]!
    var filteredBusiness: [Business]!
    //UISearch
    var searchBarController: UISearchController!      //variable for the searchBar within NavigationController
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension    //This is for setting the table view to automatic
        tableView.estimatedRowHeight = 120 //For creating a scrollView line with estimated row high

        //SearchBar within Navigation Controller(but different from standalone SearchBar)
        searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchResultsUpdater = self
        searchBarController.searchBar.sizeToFit()
        navigationItem.titleView = searchBarController.searchBar
        searchBarController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        Business.searchWithTerm("Latin", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusiness = self.businesses
            self.tableView.reloadData()
            
        })
    }
    
    //Method for searchController
    func updateSearchResultsForSearchController(searchController: UISearchController){
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty {
                self.filteredBusiness = self.businesses
            }
            else {
                
                self.filteredBusiness = businesses!.filter({ (busines: Business) -> Bool in
                    if let title = busines.name{
                        //If the Data is similar to what your are searching, put it in the array
                        if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                            return  true
                        }
                            //If not, pass
                        else{
                            return false
                        }
                    }
                    return false
                })
            }
            tableView.reloadData()
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if businesses != nil{
            return filteredBusiness.count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = filteredBusiness[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "FilterView"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let filtersViewController = navigationController.topViewController as! FiltersViewController
        
            filtersViewController.delegate = self
        } else if segue.identifier == "InfoView"{
        
            //Get the details from the selected Cell
            let specificCell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(specificCell)
            let specificBusiness = businesses![indexPath!.row]
        
            //Pass the information to the other Controller
            let mapsViewController = segue.destinationViewController as! mapViewController
            mapsViewController.business = specificBusiness
        }
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        
        Business.searchWithTerm("Restaurants", sort: nil, categories: categories, deals: nil, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusiness = self.businesses
            self.tableView.reloadData()
            
        })
    }
    
}
