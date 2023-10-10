//
//  CatBreedViewModel.swift
//  CatBreedsList-final
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import Foundation

class CatBreedViewModel: ObservableObject {

    @Published var catBreeds: [CatBreed] = []
    @Published var favorites: [CatBreed] = []
    
    
    @MainActor
    func publishCats(cats: [CatBreed], favorites: [CatBreed]) {
        self.catBreeds = cats
        self.favorites = favorites
    }
    
//    func fetchCatsMock() async {
//        await publishCats(
//            cats: [
//                CatBreed(id: "favorite", name: "favorite Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//                CatBreed(id: "id", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//                CatBreed(id: "id", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//                CatBreed(id: "id", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//            ],
//            favorites: [
//                CatBreed(id: "favorite", name: "favorite Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//            ]
//        )
//    }
    
    func fetchCats() async {
        let allCats = await fetchCatWithImages()
        let favoriteCats = await fetchFavoriteCats(cats: allCats)
        await publishCats(cats: allCats, favorites: favoriteCats)
    }
    
    private func fetchCatWithImages() async -> [CatBreed] {
        await API.getBreedsWithImage()
    }
    
    private func fetchFavoriteCats(cats: [CatBreed]) async -> [CatBreed] {
        let favorites = await API.getFavorites()
        var newCats: [CatBreed] = []
        for cat in cats {
            let catIsInFavorites = favorites.contains { $0.imageID == cat.image!.id }
            if catIsInFavorites {
                newCats.append(cat)
            }
        }
        return newCats
    }
    
    func addFavorite(cat: CatBreed) async -> Bool {
        await API.addFavorite(cat: cat)
    }
    
    func removeFavorite(cat: CatBreed) async -> Bool {
        let favorites = await API.getFavorites()
        let favorite = favorites.first { $0.imageID == cat.image!.id }
        if let id = favorite?.id {
            return await API.removeFavorite(id)
        }
        return false
    }

}

