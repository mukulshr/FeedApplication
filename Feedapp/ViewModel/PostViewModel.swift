
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
    
  
    
    func login(onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void,email: String, password: String){
   
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
                        print(datos.data.profile_pic,"Employer data we need")
                        UserDefaults.standard.setValue(1, forKey: "sesion")
                        UserDefaults.standard.set(datos.data.auth_token, forKey: "Token")
                        UserDefaults.standard.set(datos.data.profile_pic, forKey: "Profile_pic")
                        UserDefaults.standard.set(datos.data.company_logo, forKey: "Company_pic")
                        UserDefaults.standard.set(datos.data.organization, forKey: "organization")
                        UserDefaults.standard.set(datos.data.f_name, forKey: "First_Name")
                        UserDefaults.standard.set(datos.data.organisation_name, forKey: "organisation_name")
                        UserDefaults.standard.set(datos.data.id, forKey: "id")
                        UserDefaults.standard.set(datos.data.employer?.data?.employerId, forKey: "employerId")
                        self.authenticated = 1

                    }
                }
            } catch let error as NSError {
                print("Error al hacer POST", error.localizedDescription)
                DispatchQueue.main.async {
                    print("Unable to Login")
                }
            }
        }.resume()
    }
    
    
    
    
    func signup(f_name:String,l_name:String,email: String, password: String,countrycode:String,contactno:String,ipaddress:String){
        
        let parameters = "{\r\n    \"action\": \"sign_up\",\r\n    \"data\": {\r\n        \"f_name\": \"\(f_name)\",\r\n        \"l_name\": \"\(l_name)\",\r\n        \"email\": \"\(email)\",\r\n        \"password\": \"\(password)\",\r\n        \"country_code\": \"\(countrycode)\",\r\n        \"contact_no\": \"\(contactno)\",\r\n        \"regIpAddress\": \"\(ipaddress)\"\r\n    }\r\n}"
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
                
            } catch let error as NSError {
                print("Error al hacer POST", error.localizedDescription)
                DispatchQueue.main.async {
                   print("issues")
                }
            }
        }.resume()
    }
    
    
}
