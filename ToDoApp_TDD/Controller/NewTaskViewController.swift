//
//  NewTaskViewController.swift
//  ToDoApp_TDD
//
//  Created by Macbook on 05.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func save() {
        let titleString = titleTextField.text
        let locationString = locationTextField.text
        let descriptionString = descriptionTextField.text
        let addressString = addressTextField.text
        let dateString = dateFormatter.date(from:  dateTextField.text!)
        geocoder.geocodeAddressString(addressString!) { [unowned self] (placemarks, error) in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString!, coordinate: coordinate)
            
            let task = Task(title: titleString!, description: descriptionString, date: dateString, location: location)
            
            self.taskManager.add(task: task)
        }
    }
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
