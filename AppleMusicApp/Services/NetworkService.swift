//
//  NetworkService.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 05.09.2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchTracks(searchText: String, completion: @escaping (Result<TrackModel, Error>) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": "\(searchText)",
                          "limit": "15",
                          "media": "music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { data in
            if let error = data.error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let data = data.data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let tracks = try decoder.decode(TrackModel.self, from: data)
                completion(.success(tracks))
            } catch let error {
                print("Failed to decode JSON", error)
                completion(.failure(error))
            }
        }
        
        
    }
    
}

