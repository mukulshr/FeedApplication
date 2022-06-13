//
//  ProfileModel.swift
//  Feedapp
//
//  Created by Gagandeep on 13/06/22.
//

import Foundation
import SwiftUI


//Dashboard of User Profile

struct profiledashresposne: Decodable {
    let status: Int
    let message: String
    var data: profiledashdata
}

struct profiledashdata: Decodable {
    let stories: String
    let events: String
    let sponsored: String
    let activeUserEmployerName: String
}

