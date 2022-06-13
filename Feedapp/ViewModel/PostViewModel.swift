
import Foundation

class PostViewModel: ObservableObject {
    
    @Published var authenticated = 0
    
    init(){
        if let sesion = UserDefaults.standard.object(forKey: "sesion") as? Int {
            authenticated = sesion
        }else{
            authenticated = 0
        }
    }
    
    func login(email: String, password: String){
        let parameters = "{\r\n    \"action\": \"authenticate\",\r\n    \"data\": {\r\n        \"username\": \"\(email)\",\r\n        \"password\": \"\(password)\"\r\n    }\r\n}"
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
                print("success")
                let datos = try JSONDecoder().decode(PostModel.self, from: data)
                if !datos.data.auth_token.isEmpty{

                    DispatchQueue.main.async {
                        print(datos.data.employer.data.employerId,"Employer data we need")
                        UserDefaults.standard.setValue(1, forKey: "sesion")
                        UserDefaults.standard.set(datos.data.auth_token, forKey: "Token")
                        UserDefaults.standard.set(datos.data.profile_pic, forKey: "Profile_pic")
                        UserDefaults.standard.set(datos.data.company_logo, forKey: "Company_pic")
                        UserDefaults.standard.set(datos.data.organization, forKey: "organization")
                        UserDefaults.standard.set(datos.data.id, forKey: "id")
                        UserDefaults.standard.set(datos.data.employer.data.employerId, forKey: "employerId")
                        self.authenticated = 1

                    }
                }
            } catch let error as NSError {
                print("Error al hacer POST", error.localizedDescription)
                DispatchQueue.main.async {
                    self.authenticated = 2
                }
            }
        }.resume()
    }
    
    
    
    
    
    
    
    
}
