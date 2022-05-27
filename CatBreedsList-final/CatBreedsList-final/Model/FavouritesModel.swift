//
//  FavouritesModel.swift
//  CatBreedsList-final
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import Foundation

struct Favourite: Codable {
    let id: Int?
    let imageID: String
    let subID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageID = "image_id"
        case subID = "sub_id"
    }
    
    init(id: Int? = nil, imageID: String, subID: String) {
        self.id = id
        self.imageID = imageID
        self.subID = subID
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.imageID, forKey: .imageID)
        try container.encode(self.subID, forKey: .subID)
    }
}
