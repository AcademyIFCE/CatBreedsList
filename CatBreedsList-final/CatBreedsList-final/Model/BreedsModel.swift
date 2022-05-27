//
//  CatBreed.swift
//  CatBreedsList-final
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import Foundation

struct CatBreed: Decodable {
    let id: String
    let name: String
    let lifeSpan: String
    let image: BreedImage?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case lifeSpan = "life_span"
    }

    var imageURL: URL {
        URL(string: self.image!.url!)!
    }
}

struct BreedImage: Decodable {
    let id: String?
    let url: String?
}

