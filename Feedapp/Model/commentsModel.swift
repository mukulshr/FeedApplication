//
//  commentsModal.swift
//
//  Created by Gagandeep on 02/05/22.
//

import Foundation


struct getcmntfirst: Decodable {
    let status: Int
    let message: String
    var data: [reqgetcmnt]
}

struct reqgetcmnt: Codable,Equatable {
    let id: Int
    let userName: String
    let post_comment: String
    let created_at: String
    let mine: Bool
    let replyCount:Int
    let profilePic:String
}


struct getcmntreplies: Decodable {
    let status: Int
    let message: String
    var data: [reqreplies]
}

struct reqreplies: Codable,Equatable {
    let id: Int
    let comment_reply: String
    let userName: String
    let mine: Bool
    let profilePic:String
    let created_at:String
}
