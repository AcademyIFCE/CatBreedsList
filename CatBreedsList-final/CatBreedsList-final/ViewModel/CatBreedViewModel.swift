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
    func publishCats(cats: [CatBreed], favourites: [CatBreed]) {
        self.catBreeds = cats
        self.favorites = favourites
    }
    
//    func fetchCatsMock() async {
//        await publishCats(
//            cats: [
//                CatBreed(id: "favourite", name: "Favourite Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//                CatBreed(id: "id", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//                CatBreed(id: "id", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//                CatBreed(id: "id", name: "Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//            ],
//            favourites: [
//                CatBreed(id: "favourite", name: "Favourite Cat", lifeSpan: "14 to 18", image: BreedImage(id: "0", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")),
//            ]
//        )
//    }
    
    func fetchCats() async {
        let allCats = await fetchCatWithImages()
        let favouriteCats = await fetchFavouriteCats(cats: allCats)
        await publishCats(cats: allCats, favourites: favouriteCats)
    }
    
    private func fetchCatWithImages() async -> [CatBreed] {
        await API.getBreedsWithImage()
    }
    
    private func fetchFavouriteCats(cats: [CatBreed]) async -> [CatBreed] {
        let favourites = await API.getFavourites()
        var newCats: [CatBreed] = []
        for cat in cats {
            let catIsInFavourites = favourites.contains { $0.imageID == cat.image!.id }
            if catIsInFavourites {
                newCats.append(cat)
            }
        }
        return newCats
    }
    
    func addFavorite(cat: CatBreed) async -> Bool {
        await API.addFavourite(cat: cat)
    }
    
    func removeFavorite(cat: CatBreed) async -> Bool {
        let favourites = await API.getFavourites()
        let favourite = favourites.first { $0.imageID == cat.image!.id }
        if let id = favourite?.id {
            return await API.removeFavourite(id)
        }
        return false
    }

}

