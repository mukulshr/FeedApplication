
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
    var id: String
    var organization: String
    var f_name: String
    var organisation_name: String?
    var employer: employesdata?
}

struct employesdata: Decodable{
    var totalCount: Int?
    var data: allemployes?
}

struct allemployes: Decodable{
    var employerId: String?
}
