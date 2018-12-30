//
//  NotesModel.swift
//  LandmarkRemark
//
//  Created by Shanya Vairawanathan on 30/12/18.
//  Copyright © 2018 Shanya Vairawanathan. All rights reserved.
//

class NotesModel {
    var id: String?
    var Username: String?
    var Note: String?
    var Logitude: Double?
    var Latitude: Double?
    
    init(id:String?, Username: String?, Note: String?, Longitude: Double?, Latitude: Double?){
        self.id = id;
        self.Username = Username
        self.Note = Note
        self.Logitude = Longitude
        self.Latitude = Latitude
    }
}
