//
//  mapViewController.swift
//  Yelp
//
//  Created by Jamel Peralta Coss on 2/8/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var foodView: UIImageView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    var business: Business!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodView.setImageWithURL(business.imageURL!)
        foodLabel.text = business.name
        placeLabel.text = business.categories
        print("\(business.address!)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = business.address
        request.region = mapView.region

        
        let search = MKLocalSearch(request: request)
      
        search.startWithCompletionHandler {(response, error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            }else if response!.mapItems.count == 0 {
                print("No matches found")
            }else {
                print("Matches found")
                
                for item in response!.mapItems {
                    
                    self.matchingItems.append(item as MKMapItem)
                
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }

}
