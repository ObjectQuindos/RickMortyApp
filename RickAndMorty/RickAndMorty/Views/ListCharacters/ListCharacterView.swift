//
//  ContentView.swift
//  RickAndMorty
//
//  Created by David López on 22/10/23.
//

import SwiftUI

struct ListCharacterView: View {
    
    @ObservedObject var viewModel = ListCharactersViewModel()
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                ForEach(viewModel.characterList, id: \.id) { item in
                    
                    let viewModel = CharacterDetailViewModel(character: item)
                    NavigationLink(destination: CharacterDetailView(viewModel: viewModel)) {
                        CharacterCellView(element: item)
                    }
                }
                
                if self.viewModel.hasNextPagination {
                    loadingView
                }
            }
            .navigationTitle(UIStrings.characterListNavigationTitle)
            .listStyle(.plain)
            .padding(.bottom)
            .accessibilityIdentifier(UIStrings.listCharactersIdentifier)
        }
        .searchable(text: $searchText) {
            ForEach(searchResults, id: \.id) { result in
                
                let viewModel = CharacterDetailViewModel(character: result)
                NavigationLink(destination: CharacterDetailView(viewModel: viewModel)) {
                    Text(result.name).searchCompletion(result.name)
                }
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
    
    var searchResults: [CharacterModel] {
        
        if searchText.isEmpty {
            return viewModel.characterList.map { $0 }
            
        } else {
            
            let filtered = viewModel.characterList.filter { (item: CharacterModel) -> Bool in
                return item.name.lowercased().contains(searchText.lowercased())
            }
            
            if filtered.count == 0 {
                return [CharacterModel.emptyCharacter]
            }
            
            return filtered
        }
    }
    
    var loadingView: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }.task {
            await viewModel.loadMoreItems()
        }
    }
}

struct CharacterCellView: View {
    
    var element: CharacterModel
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            KingFisherImageView(url: element.imageURL, size: Constants.thumbnailSize)
                .resizable()
                .frame(width: Constants.thumbnailSize.width, height: Constants.thumbnailSize.height)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(element.name).bold()
                Text(element.gender).italic()
            }
            .padding(.vertical, 12)
        }
    }
}

/*struct ListCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ListCharacterView()
    }
}*/
