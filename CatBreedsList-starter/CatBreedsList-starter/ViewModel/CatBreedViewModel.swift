//
//  CatBreedViewModel.swift
//  CatBreedsList-starter
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import Foundation

class CatBreedViewModel: ObservableObject {

    @Published var catBreeds: [CatBreed] = []
    @Published var favorites: [CatBreed] = []
    
    @MainActor
    func publishCats(cats: [CatBreed], favourites: [CatBreed]) {
        self.catBreeds = cats
        self.favorites = favourites
    }
    
    func fetchCatsMock() async {
        await publishCats(
            cats: [
                CatBreed(id: "favourite", name: "Favourite Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
                CatBreed(id: "id1", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
                CatBreed(id: "id2", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
                CatBreed(id: "id3", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
            ],
            favourites: [
                CatBreed(id: "favourite", name: "Favourite Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
            ]
        )
    }

}

