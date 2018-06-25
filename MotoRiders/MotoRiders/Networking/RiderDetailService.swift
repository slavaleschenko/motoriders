//
//  RiderDetailService.swift
//  MotoRiders
//
//  Created by Admin on 25.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import Foundation

class RiderDetailService {
    typealias JSONDictionary = [String: Any]
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    let constants = Constants()
    var rider = [RiderDetail]()
    
    func getRiderDetails(uid: String, completion: @escaping ([RiderDetail]) -> ()) {
        
        guard let url = URL(string: "\(constants.baseUrl)\(constants.profile)\(uid).json") else {
            print("url is equal to nil")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self?.updateRiderData(data)
                DispatchQueue.main.async {
                    completion(self?.rider ?? [])
                }
            } else {
                print("ERROR: Problem with response, data, error")
            }
        }
        dataTask?.resume()
    }
    
    fileprivate func updateRiderData(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        guard let responseArray = response,
            let array = responseArray.first?.value as? JSONDictionary else {
                print("Dictionary does not contain data key\n")
                return
        }
        guard let name = array["name"] as? String,
            let team = array["team"] as? String,
            let bike = array["bike"] as? String,
            let placeOfBirth = array["placeOfBirth"] as? String,
            let dateOfBirth = array["dateOfBirth"] as? String,
            let weigth = array["weight"] as? String,
            let height = array["height"] as? String,
            let photoUrl = array["photoUrl"] as? String,
            let uid = array["uid"] as? String,
            let teamUid = array["teamUid"] as? String,
            let number = array["number"] as? String,
            let profile = array["profile"] as? String else {
                print("Error")
                return
        }
        rider.append(RiderDetail(name: name, team: team, bike: bike, placeOfBirth: placeOfBirth, dateOfBirth: dateOfBirth, weigth: weigth, height: height, photoUrl: photoUrl, uid: uid, teamUid: teamUid, number: number, profile: profile))
        
    }
    
}
