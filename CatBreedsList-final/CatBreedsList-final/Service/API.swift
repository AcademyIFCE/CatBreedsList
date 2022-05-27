//
//  API.swift
//  CatBreedsList-final
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import Foundation

class API {
        
    static func getBreedsWithImage() async -> [CatBreed] {
        var urlRequest = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/breeds")!)
        urlRequest.allHTTPHeaderFields = [
            "x-api-key": "5cffc6c8-0e59-497e-a9ef-d1b266411e9c"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let catBreedsDecoded = try JSONDecoder().decode([CatBreed].self, from: data)
            let catBreedsWithImage = catBreedsDecoded.filter { $0.image != nil && $0.image!.url != nil }
            return catBreedsWithImage
        } catch {
            print(error)
        }
        return []
    }
    
    static func getFavourites() async -> [Favourite] {
        var urlRequest = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites")!)
        urlRequest.allHTTPHeaderFields = [
            "x-api-key": "5cffc6c8-0e59-497e-a9ef-d1b266411e9c"
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try JSONDecoder().decode([Favourite].self, from: data)
        } catch {
            print(error)
        }
        return []
    }
    
    static func addFavourite(cat: CatBreed) async -> Bool {
        guard let imageID = cat.image?.id else { return false }
        
        var urlRequest = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites")!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "x-api-key": "5cffc6c8-0e59-497e-a9ef-d1b266411e9c"
        ]

        do {
            urlRequest.httpBody = try JSONEncoder().encode(Favourite(imageID: imageID, subID: "User-123")) 
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            if let responseHeader = response as? HTTPURLResponse {
                return (responseHeader.statusCode == 200)
            }       
        } catch {
            print(error)
        }
        return false
    }
    
    static func removeFavourite(_ favouriteID: Int) async -> Bool {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com"
        components.path = "/v1/favourites/\(favouriteID)"
        let url = components.url!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.allHTTPHeaderFields = [
            "x-api-key": "5cffc6c8-0e59-497e-a9ef-d1b266411e9c"
        ]

        do { 
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            if let responseHeader = response as? HTTPURLResponse {
                return (responseHeader.statusCode == 200)
            }            
        } catch {
            print(error)
        }
        return false
    }
}
