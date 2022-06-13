//
//  ProfileViewModel.swift
//  Feedapp
//
//  Created by Gagandeep on 13/06/22.
//

import Foundation




class profiledashboardapiCall {
    
    @Published var profiledash = profiledashdata(stories: "0", events: "0", sponsored: "0",activeUserEmployerName:"-")
    
    func getprofiledashboard(completion:@escaping (profiledashdata) -> ()) {
        
        let parameters = "{\r\n    \"action\": \"get_profile_dashboard\",\r\n    \"data\": {\r\n        \"getProfileId\": \"MTE2\"\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/liveFeedApis")!,timeoutInterval: Double.infinity)
        request.addValue("eyJpdiI6ImR3MmNWOVAxd2NKV0NVaWV3QXp2eUE9PSIsInZhbHVlIjoibnZLR2k3anpRcUNaTlpxK0VTT1RzUT09IiwibWFjIjoiNWU4MTU1Y2ZjMWJiNTgzY2ZkMzdjNjc0MmYyYWRjNTk0ZWFhNDdkNWFlODYxOTU3YjI4YjZhZjAzZmQwZThlOCJ9", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData


        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
            do {
                let prinnt = try JSONDecoder().decode(profiledashresposne.self, from: data)
                
//                let aa = prinnt.data.data
//
                self.profiledash = prinnt.data
                
                print(self.profiledash)
//                print("@@Success")
                DispatchQueue.main.async {
                    completion(self.profiledash)
                           }
                
            } catch {
                    print("JSONSerialization error:", error)
//                print("##failed")
                }
        }

        task.resume()
       

    }
}
