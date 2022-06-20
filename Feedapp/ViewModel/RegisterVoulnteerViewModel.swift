//
//  RegisterVoulnteerViewModel.swift
//  Feedapp
//
//  Created by Gagandeep on 14/06/22.
//

import Foundation


class geteventsdetail : ObservableObject{
    
    @Published var eventreq = events(eventInclusionCount:0, eventData: eventsdata(storyCreatorId:0,feedName:"-", eventLocationId:0,eventDateInstancId:0,eventDate:"-", hideName:0,cityId:0,stateId:0,countryId:0,elocation:"",start_time:"-",locationLag:"-",locationLat:"-"), eventInclusionData:[])
  
    
    func getevents(postId: Int,completion:@escaping (events) -> ()) {
        
        let parameters = "{\r\n    \"action\": \"view_physical_event\",\r\n    \"data\": {\r\n        \"postId\": 976\r\n    }\r\n}"
        
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/liveFeedApis")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("eyJpdiI6ImdySHdDKzRXZmQxSytHNkZKNDJ5Qmc9PSIsInZhbHVlIjoiSjFjYkNWTlwvcDRaazFrZWs0Rkl4eHc9PSIsIm1hYyI6ImEyNDVhYmI5ODdlNWNhYjJhODJkYjFkMGU3MTIyYzcwZjg0ODllYmVlNmM0MGRhNGQ0N2YzM2IyZTI1YjhhMmMifQ==", forHTTPHeaderField: "Authorization")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error))
           
            return
          }
            do {
                let prinnt = try JSONDecoder().decode(eventres.self, from: data)
                
                let aa = prinnt.data.eventData
                self.eventreq = prinnt.data
                
                print(self.eventreq)
                DispatchQueue.main.async {
                    completion(self.eventreq)
                           }
                
            } catch {
                    print("JSONSerialization error:", error)
                }
        }

        task.resume()
       

    }
}
