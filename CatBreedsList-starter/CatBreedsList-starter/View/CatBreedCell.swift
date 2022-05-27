//
//  CatBreedCell.swift
//  CatBreedsList-final
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import SwiftUI

struct CatBreedCell: View {
    
    @State var favorite: Bool = false
    @State var loadingFavorite: Bool = false

    let catBreed: CatBreed
    let addFavoriteHandler: ((CatBreed) async -> Bool)
    let removeFavoriteHandler: ((CatBreed) async -> Bool)
    
    init(
        catBreed: CatBreed, 
        beginsFavourited: Bool, 
        addFavoriteHandler: @escaping ((CatBreed) async -> Bool), 
        removeFavoriteHandler: @escaping ((CatBreed) async -> Bool)
    ) {
        self.catBreed = catBreed
        self.favorite = beginsFavourited
        self.addFavoriteHandler = addFavoriteHandler
        self.removeFavoriteHandler = removeFavoriteHandler
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            AsyncImage(url: catBreed.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
                    .clipped()
            } placeholder: {
                Color.yellow.opacity(0.25)
            }
            .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)

            Spacer()

            Button(
                action: {
                    Task {
                        if favorite {
                            loadingFavorite = true
                            if await removeFavoriteHandler(catBreed) {
                                favorite = false
                            }
                            loadingFavorite = false
                        } else {
                            loadingFavorite = true
                            if await addFavoriteHandler(catBreed) {
                                favorite = true
                            }
                            loadingFavorite = false
                        }
                    }
                }, 
                label: {
                    HStack(spacing: 4) {
                        ZStack {
                            if loadingFavorite {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .scaleEffect(1.2)
                            } else {
                                Image(systemName: favorite ? "heart.fill" : "heart")
                                    .font(.system(size: 30))    
                            }
                        }
                        .frame(width: 30)
                        Text(favorite ? "Meow" : "Favorite Me")
                            .font(favorite ? .system(size: 18, weight: .medium, design: .rounded) : .system(size: 18).italic())
                    }
                    .foregroundColor(favorite ? .pink : .black)
                    .frame(height: 30)
                }
            )
            .buttonStyle(.plain)
            .padding(.bottom, 10)

            Text("Breed: \(catBreed.name)").font(.system(.headline))
            Text("Life Span: \(catBreed.lifeSpan) years").font(.system(.subheadline))
        }
        .padding()
        .background(
            Color.white.shadow(
                color: Color.black.opacity(0.25),
                radius: 3,
                x: 3,
                y: 2
            )
        )
    }
}
