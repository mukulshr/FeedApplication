//
//  VolunteerModel.swift
//  Feedapp
//
//  Created by Gagandeep on 14/06/22.
//

import Foundation


struct eventres: Decodable {
    let status: Int
    let message: String
    var data: events
}


struct events: Decodable {
    let eventInclusionCount: Int
    let eventData: eventsdata
    let eventInclusionData:[String]
   
}

struct eventsdata: Decodable{
    let storyCreatorId: Int
    
    let feedName : String
    let eventLocationId: Int
    let eventDateInstancId: Int
    let eventDate : String
    let hideName: Int
    
    let cityId: Int
    let stateId: Int
    let countryId: Int
    let elocation: String
    let start_time:String
    
    let locationLag:String
    let locationLat:String
}
