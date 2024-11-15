//
//  Networkfile.swift
//  videoAssingment
//
//  Created by Netprophets on 13/11/24.
//

import Foundation


class NetworkManager {
    
    func parseJson(completion:@escaping(VideoData?)->()){
        do {
            
            guard let bundle = Bundle.main.path(forResource: "data", ofType: "json") else {return}
            guard let jsonData = try String(contentsOfFile: bundle).data(using: .utf8) else {return}
            
            let data = try JSONDecoder().decode(VideoData.self, from: jsonData)
            completion(data)
//            print(data)
        }
        catch {
            print(error)
        }
    }
    
}
