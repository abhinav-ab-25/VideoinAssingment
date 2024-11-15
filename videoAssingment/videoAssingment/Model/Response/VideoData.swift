//
//  videoData.swift
//  videoAssingment
//
//  Created by Abhinav  on 13/11/24.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let videoData = try? JSONDecoder().decode(VideoData.self, from: jsonData)

import Foundation

// MARK: - VideoDatum
struct VideoDatum: Codable {
    var id: String?
    var title: String?
    var thumbnailURL: String?
    var duration: String?
    var uploadTime: String?
    var views: String?
    var author: String?
    var videoURL: String?
    var description: String?
    var subscriber: String?
    var isLive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnailURL = "thumbnailUrl"
        case duration, uploadTime, views, author
        case videoURL = "videoUrl"
        case description, subscriber, isLive
    }
}

typealias VideoData = [VideoDatum]

