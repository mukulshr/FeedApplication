//
//  commentsViewModal.swift
//
//  Created by Gagandeep on 02/05/22.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration



class getcomments {
    
    @Published var getcmnt = [reqgetcmnt]()
    
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    
    func getcomment(need: String,needpostid: Int,needId:Int,completion:@escaping ([reqgetcmnt]) -> ()) {
        
        let parameters = "{\r\n    \"action\": \"get_comments\",\r\n    \"data\": {\r\n        \"actionType\": \"select\",\r\n        \"activityId\": \(needId),\r\n        \"interaction\": \"comment\",\r\n        \"postId\": \(needpostid)\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
        request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData


        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
            do {
                let prinnt = try JSONDecoder().decode(getcmntfirst.self, from: data)
                
//                let aa = prinnt.data.data
//
                self.getcmnt = prinnt.data
                
//                print(self.getcmnt,"@@@@@",need,needpostid,needId)
//                print("@@Success")
                DispatchQueue.main.async {
                    completion(self.getcmnt)
                           }
                
            } catch {
                    print("JSONSerialization error:", error)
//                print("##failed")
                }
        }

        task.resume()
       

    }
}


class addcomments {
    
    func addcomment(need: String,needpostid: Int,needId:Int) {
        
        let parameters = "{\r\n    \"action\": \"add_comment\",\r\n    \"data\": {\r\n        \"interaction\": \"comment\",\r\n        \"actionType\": \"create\",\r\n        \"comment\": \"\(need)\",\r\n        \"postId\": \(needpostid),\r\n        \"activityId\": \(needId)\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
        request.addValue("eyJpdiI6ImR3MmNWOVAxd2NKV0NVaWV3QXp2eUE9PSIsInZhbHVlIjoibnZLR2k3anpRcUNaTlpxK0VTT1RzUT09IiwibWFjIjoiNWU4MTU1Y2ZjMWJiNTgzY2ZkMzdjNjc0MmYyYWRjNTk0ZWFhNDdkNWFlODYxOTU3YjI4YjZhZjAzZmQwZThlOCJ9", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
        
                let result = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let result = result {
                    DispatchQueue.main.async {
                        print("Done Comment Added !")
                        
                    }

                } else {
                    DispatchQueue.main.async {
                        print("Invalid response from web services!")
                    }
                }

//                print("@@@@@",need,needpostid,needId)
//                print("@@Success")
//                DispatchQueue.main.async {
//                    completion(self.getcmnt)
//                           }
                
        }

        task.resume()
       

    }
}

public class deletecomment: ObservableObject {
    
    @Published var  delete: String = ""
    
    func delete(need: String,needpostid: Int,needId:Int,id: Int) {
        
        let parameters = "{\r\n    \"action\": \"add_comment\",\r\n    \"data\": {\r\n        \"interaction\": \"comment\",\r\n        \"actionType\": \"delete\",\r\n        \"id\":\(id),\r\n        \"comment\": \"\(need)\",\r\n        \"postId\":  \(needpostid),\r\n        \"activityId\": \(needId)\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
        request.addValue("eyJpdiI6ImR3MmNWOVAxd2NKV0NVaWV3QXp2eUE9PSIsInZhbHVlIjoibnZLR2k3anpRcUNaTlpxK0VTT1RzUT09IiwibWFjIjoiNWU4MTU1Y2ZjMWJiNTgzY2ZkMzdjNjc0MmYyYWRjNTk0ZWFhNDdkNWFlODYxOTU3YjI4YjZhZjAzZmQwZThlOCJ9", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData


        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
        
                let result = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let result = result {
                    DispatchQueue.main.async {
                        self.delete = "DONE"
                        print("Done Comment Deleted !")
                        
                    }

                } else {
                    DispatchQueue.main.async {
                        self.delete = "ERROR"
                        print("Invalid response from web services!")
                    }
                }

//                print("@@@@@",need,needpostid,needId)
//                print("@@Success")
//                DispatchQueue.main.async {
//                    completion(self.getcmnt)
//                           }
                
        }

        task.resume()
       

    }
}



public class editcomment: ObservableObject {
    
    @Published var  edited: String = ""
    
func edit(need: String,needpostid: Int,needId:Int,id: Int) {
    
    let parameters = "{\r\n    \"action\": \"add_comment\",\r\n    \"data\": {\r\n        \"interaction\": \"comment\",\r\n        \"actionType\": \"update\",\r\n        \"id\":\(id),\r\n        \"comment\": \"\(need)\",\r\n        \"postId\":  \(needpostid),\r\n        \"activityId\": \(needId)\r\n    }\r\n}"
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
    request.addValue("eyJpdiI6ImR3MmNWOVAxd2NKV0NVaWV3QXp2eUE9PSIsInZhbHVlIjoibnZLR2k3anpRcUNaTlpxK0VTT1RzUT09IiwibWFjIjoiNWU4MTU1Y2ZjMWJiNTgzY2ZkMzdjNjc0MmYyYWRjNTk0ZWFhNDdkNWFlODYxOTU3YjI4YjZhZjAzZmQwZThlOCJ9", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData


    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else {
        print(String(describing: error))
       
        return
      }
    
            let result = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let result = result {
                DispatchQueue.main.async {
                    self.edited = "DONE"
                    print("Done Comment Added !")
                    
                }

            } else {
                DispatchQueue.main.async {
                    self.edited = "ERROR"
                    print("Invalid response from web services!")
                }
            }

            print("@@@@@",need,needpostid,needId)
//                print("@@Success")
//                DispatchQueue.main.async {
//                    completion(self.getcmnt)
//                           }
            
    }

    task.resume()
   
}
}



class replycomment {
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    func replycomment(commentid: Int,reply: String) {
        
        
        let parameters = "{\r\n    \"action\": \"add_comment\",\r\n    \"data\": {\r\n        \"actionType\": \"create\",\r\n        \"commentId\": \(commentid),\r\n        \"interaction\": \"reply\",\r\n        \"reply\":\"\(reply)\"\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
        request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
        
                let result = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let result = result {
                    DispatchQueue.main.async {
                        print("Done Reply Added !")
                        
                    }

                } else {
                    DispatchQueue.main.async {
                        print("Invalid response from web services!")
                    }
                }
                
        }

        task.resume()
       

    }
}



class getcommentreplies{
    
    @Published var getreplies = [reqreplies]()
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    
    func getcommentreply(needId:Int,completion:@escaping ([reqreplies]) -> ()) {
        
       
        let parameters = "{\r\n    \"action\": \"get_comments\",\r\n    \"data\": {\r\n        \"actionType\": \"select\",\r\n        \"commentId\": 148,\r\n        \"interaction\": \"reply\"\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
        request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData


        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
            do {
                let prinnt = try JSONDecoder().decode(getcmntreplies.self, from: data)
                

                self.getreplies = prinnt.data
                print(self.getreplies)
                
                DispatchQueue.main.async {
                    completion(self.getreplies)
                           }
                
            } catch {
                    print("JSONSerialization error:", error)
                
            }
        }

        task.resume()
       

    }
}
