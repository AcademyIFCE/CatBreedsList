//
//  CatBreedList.swift
//  CatBreedsList-starter
//
//  Created by Gabriela Bezerra on 27/05/22.
//

import SwiftUI

struct CatBreedList: View {
    
    @ObservedObject var viewModel: CatBreedViewModel = CatBreedViewModel()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.5).ignoresSafeArea()
            if viewModel.catBreeds.isEmpty {
                emptyState   
            } else {
                catBreedsList
            }
        }
        .task {
            await viewModel.fetchCatsMock()
        }
    }
    
    var emptyState: some View {
        VStack {
            Image("cat")
            Text("Loading Cats").font(.title)
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
                .padding()
        }
    }
    
    var catBreedsList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.catBreeds, id: \.id) { cat in
                CatBreedCell(
                    catBreed: cat,
                    beginsFavorited: viewModel.favorites.contains { cat.id == $0.id },
                    addFavoriteHandler: { _ in
                        print("Add Favorite")
                        return true
                    },
                    removeFavoriteHandler: { _ in
                        print("Remove Favorite")
                        return true
                    }
                )
                .padding(20)
            }
        }
    }
}

struct CatBreedList_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedList()
    }
}
