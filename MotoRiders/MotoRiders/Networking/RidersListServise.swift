//
//  RidersListServise.swift
//  MotoRiders
//
//  Created by Admin on 22.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import Foundation

class RidersListService {
    typealias JSONDictionary = [String: Any]
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    let constants = Constants()
    var ridersData = [Riders]()
    
    func getRidersData(team: String, completion: @escaping ([Riders]) -> ()) {
        
        guard let url = URL(string: "\(constants.baseUrl)\(constants.rider)") else {
            print("url is equal to nil")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self?.updateRidersData(data, teamName: team)
                DispatchQueue.main.async {
                    completion(self?.ridersData ?? [Riders]())
                }
            } else {
                print("ERROR: Problem with response, data, error")
            }
        }
        dataTask?.resume()
    }
    
    fileprivate func updateRidersData(_ data: Data, teamName: String) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        guard let responseArray = response,
            let array = responseArray.first?.value as? [JSONDictionary] else {
                print("Dictionary does not contain data key\n")
                return
        }
        for index in 0...array.count-1 {
            if let elements = array[index] as? JSONDictionary {
               guard let name = elements["name"] as? String,
                let team = elements["team"] as? String,
                let bike = elements["bike"] as? String,
                let placeOfBirth = elements["placeOfBirth"] as? String,
                let dateOfBirth = elements["dateOfBirth"] as? String,
                let weigth = elements["weight"] as? String,
                let height = elements["height"] as? String,
                let photoUrl = elements["photoUrl"] as? String,
                let uid = elements["uid"] as? String,
                let teamUid = elements["teamUid"] as? String,
                let number = elements["number"] as? String else {
                    print("Error")
                    return
                }
                var array = [Riders]()
                array.append(Riders(name: name, team: team, bike: bike, placeOfBirth: placeOfBirth, dateOfBirth: dateOfBirth, weigth: weigth, height: height, photoUrl: photoUrl, uid: uid, teamUid: teamUid, number: number))
                
                for riders in array where riders.team == teamName {
                    ridersData.append(riders)
                }
            } else {
                print("Problem parsing params\n")
            }
        }
    }
    
    //MARK: FULL LIST Riders
    
    func getFullListRiders(completion: @escaping ([Riders]) -> ()) {
        
        guard let url = URL(string: "\(constants.baseUrl)\(constants.rider)") else {
            print("url is equal to nil")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self?.updateFullListRidersData(data)
                DispatchQueue.main.async {
                    completion(self?.ridersData ?? [Riders]())
                }
            } else {
                print("ERROR: Problem with response, data, error")
            }
        }
        dataTask?.resume()
    }
    
    fileprivate func updateFullListRidersData(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        guard let responseArray = response,
            let array = responseArray.first?.value as? [JSONDictionary] else {
                print("Dictionary does not contain data key\n")
                return
        }
        for index in 0...array.count-1 {
            if let elements = array[index] as? JSONDictionary {
                guard let name = elements["name"] as? String,
                    let team = elements["team"] as? String,
                    let bike = elements["bike"] as? String,
                    let placeOfBirth = elements["placeOfBirth"] as? String,
                    let dateOfBirth = elements["dateOfBirth"] as? String,
                    let weigth = elements["weight"] as? String,
                    let height = elements["height"] as? String,
                    let photoUrl = elements["photoUrl"] as? String,
                    let uid = elements["uid"] as? String,
                    let teamUid = elements["teamUid"] as? String,
                    let number = elements["number"] as? String else {
                        print("Error")
                        return
                }
                ridersData.append(Riders(name: name, team: team, bike: bike, placeOfBirth: placeOfBirth, dateOfBirth: dateOfBirth, weigth: weigth, height: height, photoUrl: photoUrl, uid: uid, teamUid: teamUid, number: number))
            } else {
                print("Problem parsing params\n")
            }
        }
    }
    
}
