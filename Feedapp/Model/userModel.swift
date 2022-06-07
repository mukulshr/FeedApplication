import SwiftUI

struct firstdata: Decodable {
    let status: Int
    let message: String
    var data: extradata
}

struct extradata: Decodable {
    let totalCount: Int
    let data: [reqdata]
}

struct reqdata: Codable,Equatable ,Hashable{
    let id: Int
    let postId: Int
    let post_type: String
    let maxFeedCount: Int
    let feed_type_name: String
    let category_name: String
    let feedUserName: String
    let storyDescription:String
    let story_img:String
    let feedUserPic:String
    let name:String
    let feedDate:String
    let cityName:String
    let read_more_link:String
    let userLike:String
    let totalLikes: Int
    let feedUserType: String
    let feedType: Int
    let description: String
}


struct firstdashdata: Decodable {
    let status: Int
    let message: String
    var data: reqdash
}

struct reqdash: Decodable {
    let stories: String
    let events: String
    let sponsored: String
}


