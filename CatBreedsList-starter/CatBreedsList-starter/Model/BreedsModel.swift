//
//  CatBreed.swift
//  CatBreedsList-starter
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import Foundation

struct CatBreed {
    let id: String
    let name: String
    let lifeSpan: String
    let image: BreedImage?

    var imageURL: URL {
        URL(string: self.image!.url!)!
    }
}

struct BreedImage {
    let id: String?
    let url: String?
}

