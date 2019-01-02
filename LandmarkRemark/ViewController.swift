//
//  ViewController.swift
//  LandmarkRemark
//
//  Created by Shanya Vairawanathan on 23/12/18.
//  Copyright © 2018 Shanya Vairawanathan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    //Declaring variables
    var refNotes: DatabaseReference!
    var longitude: Double!
    var latitude: Double!

    //Creating an outlet for the map view
    @IBOutlet weak var mapView: MKMapView!
    
    //Creating a location manager to get current location
    let locationManager = CLLocationManager()

    //Instantiating the notes model
    var notesList = [NotesModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creating a database reference
        refNotes = Database.database().reference().child("notes");
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        //Getting the current location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        //Initializing the map features
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        //Setting the coordinates for the map
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
        //Adding the tap gesture to throw an alert view to enter the short note
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        mapView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
        
        //Fetching all the data from firebase
        refNotes.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.notesList.removeAll()
                
                for notes in snapshot.children.allObjects as![DataSnapshot]{
                    let notesObject = notes.value as? [String: AnyObject]
                    let notesUser = notesObject?["Username"]
                    let notesNote = notesObject?["Note"]
                    let notesID = notesObject?["id"]
                    let notesLat = notesObject?["Longitude"]
                    let notesLong = notesObject?["Latitude"]
                    
                    let notes = NotesModel(id: notesID as! String?, username: notesUser as! String?, note: notesNote as! String?, longitude: notesLong as! Double?, latitude: notesLat as! Double?)
                    
                    self.notesList.append(notes)
                    
                    //Creating and displaying annotations which were stores by previous users
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: notesLat as! CLLocationDegrees, longitude: notesLong as! CLLocationDegrees)
                    annotation.title = notesUser as! String?
                    annotation.subtitle = notesNote as! String?
                    self.mapView.addAnnotation(annotation)
                    
                }
            }
        })
        
    }

    //Getting the current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        //Storing the coordinates
        longitude = locValue.longitude
        latitude = locValue.latitude
        
        //Define the map type
        mapView.mapType = MKMapType.standard
        
        //Marking the size of the map/span and region when the map is opened
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        //Adding the annotation to the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Shanya's Location"
        annotation.subtitle = "Current location"
        mapView.addAnnotation(annotation)
        
        //centerMap(locValue)
    }
    
    //Method to handle the tap gesture
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer)
    {
        //Adding an annotation according to the location where the user selects
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Username"
        annotation.subtitle = "Note"
        mapView.addAnnotation(annotation)
        
        //Defining the outlook of the alert view
        let alert = UIAlertController(title: "Short Note",
                                      message: "Please enter a short note here",
                                      preferredStyle: .alert)
        
        // Submit button action
        let submitAction = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            print(textField.text!)
            
            let key = self.refNotes.childByAutoId().key
            
            let notes = [ "id": key as Any,
                          "Username":Auth.auth().currentUser?.email as Any,
                          "Note": textField.text! as String,
                          "Longitude": self.longitude as Double,
                          "Latitude": self.latitude as Double
                          
            ]
            
            self.refNotes.child(key!).setValue(notes)
            
        })
        
        // Cancel button action
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in
            self.mapView.removeAnnotation(annotation)
        })
        
        // Adding one textField and customizing it
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Please enter a short note here"
            textField.clearButtonMode = .whileEditing
        }
        
        //Calling all the declared methods for the alert view on tap gesture
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }

    

}

