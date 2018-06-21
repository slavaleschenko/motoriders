//
//  TeamListService.swift
//  MotoRiders
//
//  Created by Admin on 21.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import Foundation

class TeamListService {
    typealias JSONDictionary = [String: Any]
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    let constants = Constants()
    var teamData = [Team]()
    
    func getTeamData(completion: @escaping ([Team]) -> ()) {
    
        guard let url = URL(string: "\(constants.baseUrl)\(constants.team)") else {
                print("url is equal to nil")
                return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self?.updateTeamData(data)
                DispatchQueue.main.async {
                    completion(self?.teamData ?? [])
                }
            } else {
                print("ERROR: Problem with response, data, error")
            }
        }
        dataTask?.resume()
    }
    
    fileprivate func updateTeamData(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        guard let responseArray = response,
            let array = responseArray.first as? JSONDictionary else {
                print("Dictionary does not contain data key\n")
                return
        }
        let test = array.first as? [JSONDictionary]
        if  let name = test!["name"] as? String,
            let uid = test!["uid"] as? String {
            teamData.append(Team(name: name, uid: uid))
        } else {
            print("Problem parsing params\n")
        }
    }
    
}
