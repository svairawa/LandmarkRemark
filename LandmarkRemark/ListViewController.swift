//
//  ListViewController.swift
//
//  Created by Shanya Vairawanathan on 23/12/18.
//  Copyright © 2018 Shanya Vairawanathan. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var refNotes: DatabaseReference!
    var longitude: Double!
    var latitude: Double!

    @IBOutlet weak var tblNotes: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var notesList = [NotesModel]()

        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notesList.count
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewTableViewCell

            let note: NotesModel

            note = notesList[indexPath.row]

            cell.lblUser.text = note.username
            cell.lblNote.text = note.note

            print("This is the cell note: " + cell.lblNote.text!)
        //
        return cell
}
    
    //Search Functionality for the List
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        notesList = searchText.isEmpty ? notesList : notesList.filter { (item: NotesModel) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//        tblNotes.reloadData()
//    }


override func viewDidLoad() {
    super.viewDidLoad()

    
    //Creating a database reference
    refNotes = Database.database().reference().child("notes");

    //Fetching the values from Firebase Database and storing the values into variables
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

            }

            //Refresh table
            self.tblNotes.reloadData()
        }
    })
    // Do any additional setup after loading the view, typically from a nib.

}




}
