
import SwiftUI

class HeaderViewModel: ObservableObject {
    
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    func upload_pic(imagecode: String,onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void) {
        
        let parameters = "{\r\n    \"action\": \"update_profile_image\",\r\n    \"data\": {\r\n        \"pimage\": \"data:image/png;base64,\(imagecode)\"\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace.com/api/usersApis")!,timeoutInterval: Double.infinity)
        request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard let data = data else {
            print(String(describing: error),"error described")
         
            return
          }
            do {
               
                
//                print("imagecode",imagecode)
                print("ourtoken",self.AuthToken!)
                DispatchQueue.main.async {
                    print("Uploaded Successfully")
                           }
                
            } catch {
                    print("JSONSerialization error:", error)
                }
        }

        task.resume()
       

    }
}
