//
//  viewModel.swift
//  videoAssingment
//
//  Created by Netprophets on 15/11/24.
//

import Foundation


class VideoViewModel {
    let networkManager = NetworkManager()
    
    
    func parseData(completion:@escaping(VideoData?)->()){
        networkManager.parseJson{[weak self] videoData in
            guard let actualData = videoData else {return}
//            self?.data = actualData
            completion(actualData)
            
        }
    }
}
