import Foundation

class apiCall : ObservableObject{
    
    @Published var req = [reqdata]()
  
    
    func getUsers(lastid: Int,completion:@escaping ([reqdata]) -> ()) {
        
        let parameters = "{\r\n    \"action\": \"get_live_feed\",\r\n    \"data\": {\r\n         \"lastId\": \(lastid),\r\n        \"limit\":4\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/liveFeedApis")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
            do {
                let prinnt = try JSONDecoder().decode(firstdata.self, from: data)
                
                let aa = prinnt.data.data
                
//                self.req = Array(Set(self.req).union(Set(prinnt.data.data)))
//                self.req.append(prinnt.data.data)
                self.req = prinnt.data.data
                print("here is the data we want",lastid)
                
//                print(self.req)
                DispatchQueue.main.async {
                    completion(self.req)
                           }
                
//                let bb = try JSONDecoder().decode([reqdata].self, from: aa)
//
//                print(prinnt.data.data)
            } catch {
                    print("JSONSerialization error:", error)
                }
        }

        task.resume()
       

    }
}

class dashboardapiCall {
    
    @Published var dash = reqdash(stories: "0", events: "0", sponsored: "0")
    
    func getdashboard(completion:@escaping (reqdash) -> ()) {
        
        let parameters = "{\r\n    \"action\": \"get_dashboard\",\r\n    \"data\": \"\"\r\n}"
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
                let prinnt = try JSONDecoder().decode(firstdashdata.self, from: data)
                
//                let aa = prinnt.data.data
//
                self.dash = prinnt.data
                
                print(self.dash)
//                print("@@Success")
                DispatchQueue.main.async {
                    completion(self.dash)
                           }
                
            } catch {
                    print("JSONSerialization error:", error)
//                print("##failed")
                }
        }

        task.resume()
       

    }
}

