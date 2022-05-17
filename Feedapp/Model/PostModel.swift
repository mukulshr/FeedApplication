
import Foundation

struct PostModel: Decodable {
    var status: Int
    var message: String
    var data: data
}

struct data: Decodable{
    var auth_token: String
    var profile_pic: String
    var company_logo: String
}

