//
//  Data_Management.swift
//  mutual
//
//  Created by Marc Jiang on 6/14/25.
//

import UIKit

class Data_Management: Base {
    func fetchData() {
        let url_string = "\(root_folder)fetch_data.php"
        guard let url = URL(string: url_string) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, res, err in
            if err != nil {
                print(err?.localizedDescription)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let realdata = try? jsonDecoder.decode([User].self, from: data)
                
                if realdata != nil {
                    DispatchQueue.main.async {
                        //MARK: set an array equal to realdata! --> realdata! contains all of a certain data
                        //ex.) user_array = realdata!
                        all_users = realdata!
                    }
                    let realModel = realdata //MARK: optional
                }
                
            }
        }.resume()
    }
    func register_new_user(Email: String, Password: String, Name: String, ID: String, JoinDate: String, Organization: String, PhoneNumber: String, AccountPoints: String, FirebaseToken: String, SearchIsOn: String, LatCoor: String, LongCoor: String, completion: @escaping ((Error?) -> Void)){
        guard let url = URL(string: "\(root_folder)register_new_user.php") else {
            completion(ServiceError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        let formData = [
            ("Email", Email),
            ("Password", Password),
            ("Name", Name),
            ("ID", ID),
            ("JoinDate", JoinDate),
            ("Organization", Organization),
            ("PhoneNumber", PhoneNumber),
            ("AccountPoints", AccountPoints),
            ("FirebaseToken", FirebaseToken),
            ("SearchIsOn", SearchIsOn),
            ("LatCoor", LatCoor),
            ("LongCoor", LongCoor),
        ]
        
        for (key, value) in formData{
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request){data, res, err in
            if err != nil{
                completion(err)
                return
            }
            if let httpResponse = res as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        if let responseString = String(data: responseData, encoding: .utf8) {
                            //return response string
                            
                            
                        }
                    }
                } else {
                    completion(ServiceError.invalidResponseCode(httpResponse.statusCode))
                }
            } else {
                completion(ServiceError.invalidResponse)
            }
        }
        task.resume()
    }
    
    func delete_User(ID: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Define the URL of the PHP script
        let urlString = "\(root_folder)delete_user.php"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Define the parameters
        let parameters = "delete=1&ID=\(ID)"
        //MARK: NOTE the param1 inside the 'parameters' definition
        
        // Set the request body
        request.httpBody = parameters.data(using: .utf8)
        
        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    completion(.success(responseString))
                }
            } else {
                completion(.failure(NSError(domain: "HTTP Error \(httpResponse.statusCode)", code: 0, userInfo: nil)))
            }
        }
        
        // Start the task
        task.resume()
    }
    func Update_User_Info(Password: String, Name: String, ID: String, JoinDate: String, Organization: String, PhoneNumber: String, AccountPoints: String, FirebaseToken: String, SearchIsOn: String, LatCoor: String, LongCoor: String, completion: @escaping ((Error?) -> Void)){
            guard let url = URL(string: "\(root_folder)update_user_info.php") else {
                completion(ServiceError.invalidURL)
                return
            }
            print("Updating Processing")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var body = Data()
            let formData = [
                ("Password", Password),
                ("Name", Name),
                ("ID", ID),
                ("JoinDate", JoinDate),
                ("Organization", Organization),
                ("PhoneNumber", PhoneNumber),
                ("AccountPoints", AccountPoints),
                ("FirebaseToken", FirebaseToken),
                ("SearchIsOn", SearchIsOn),
                ("LatCoor", LatCoor),
                ("LongCoor", LongCoor),
            ]
            
        for (key, value) in formData{
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
            
            
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = body
            
            let task = URLSession.shared.dataTask(with: request){data, res, err in
                if err != nil{
                    completion(err)
                    return
                }
                if let httpResponse = res as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let responseData = data {
                            if let responseString = String(data: responseData, encoding: .utf8) {
                                
                                
                                
                            }
                        }
                    } else {
                        completion(ServiceError.invalidResponseCode(httpResponse.statusCode))
                    }
                } else {
                    completion(ServiceError.invalidResponse)
                }
            }
            task.resume()
        }
    
    
    func callDeepSeekAPI_for_events(userInput: String, completion: @escaping (String?) -> Void) {
        print("called")
        guard let url = URL(string: "https://api.gmi-serving.com/v1/chat/completions") else {
            completion(nil)
            return
        }
        let API_Key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZjY4ZGNiLTc2MjYtNDU1YS04MTJlLWNjZWQ0NGM1MmFmMSIsInR5cGUiOiJpZV9tb2RlbCJ9.wSR0pMUfjAfTijf8jJSaiec1FutdKCcCJq6RlJo62uM"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(API_Key)", forHTTPHeaderField: "Authorization")
        
        let payload: [String: Any] = [
            "model": "deepseek-ai/DeepSeek-R1-0528",
            "messages": [
                ["role": "system", "content": "You are a helpful AI assistant"],
                ["role": "user", "content": userInput]
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let choices = json["choices"] as? [[String: Any]],
                let message = choices.first?["message"] as? [String: Any],
                let content = message["content"] as? String
            else {
                completion(nil)
                print("error")
                return
            }
            completion(content)
        }.resume()
    }

    


    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    
    
}




class LocalStorage{
    static func setLogin(id: String, email: String, Password: String, allow_loc: Bool, imageURL: String, user_index : String){


    }
    static func save_event_status(status: Int, type: Int, time: String){
        UserDefaults.standard.set(status, forKey: "Event Status")
        UserDefaults.standard.set(type, forKey: "Event Type")
        UserDefaults.standard.set(time, forKey: "Start Time")


    }
    static func update_pfp(imageURL: String){
        UserDefaults.standard.setValue(imageURL, forKey: "image")
    }
    
    static func logout(){

    }
    
}
