//
//  CatBreedCell.swift
//  CatBreedsList-final
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import SwiftUI

struct CatBreedCell: View {
    
    @State var favorite: Bool = false

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
                        withAnimation { favorite.toggle() }
                        if favorite {
                            let success = await addFavoriteHandler(catBreed) 
                            if !success {  
                                withAnimation { favorite.toggle() }
                            }
                        } else {
                            let success = await removeFavoriteHandler(catBreed)
                            if !success { 
                                withAnimation { favorite.toggle() }
                            }
                        }
                    }
                }, 
                label: {
                    HStack(spacing: 4) {
                        ZStack {
                            Image(systemName: "heart")
                                .font(.system(size: 30))
                            Image(systemName: "heart.fill")
                                .font(.system(size: 30))
                                .opacity(favorite ? 1: 0)
                                .scaleEffect(favorite ? 1 : 0.1)
                        }
                        .frame(width: 30)
                        ZStack(alignment: .leading) {
                            Text("Favorite Me")
                                .font(.system(size: 18, weight: .medium))
                                .opacity(favorite ? 0 : 1)
                                .scaleEffect(favorite ? 0.1 : 1)
                                .frame(width: favorite ? 0.1 : 99)
                            Text("Meow")
                                .font(.system(size: 18, weight: .medium, design: .rounded).italic())
                                .opacity(favorite ? 1 : 0)
                                .scaleEffect(favorite ? 1 : 0.1)
                                .frame(width: favorite ? 50 : 0.1)
                        }
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
