//
//  NotesModel.swift
//  LandmarkRemark
//
//  Created by Shanya Vairawanathan on 30/12/18.
//  Copyright © 2018 Shanya Vairawanathan. All rights reserved.
//

class NotesModel {
    
    //Declaring and encapsulating the values from the database
    var id: String?
    var username: String?
    var note: String?
    var logitude: Double?
    var latitude: Double?
    
    init(id:String?, username: String?, note: String?, longitude: Double?, latitude: Double?){
        
        self.id = id;
        self.username = username
        self.note = note
        self.logitude = longitude
        self.latitude = latitude
    }
}
