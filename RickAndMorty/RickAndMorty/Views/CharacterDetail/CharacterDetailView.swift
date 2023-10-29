//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by David López on 25/10/23.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        
        List {
            
            if let character = viewModel.characterDetail?.character {
                CharacterImageView(url: character.imageURL)
                
                Section(header: Text(UIStrings.infoSectionTitle)) {
                    CharacterDetailInfoCellView(title: UIStrings.infoFirstRow, subtitle: character.name)
                    CharacterDetailInfoCellView(title: UIStrings.infoSecondRow, subtitle: character.gender)
                    CharacterDetailInfoCellView(title: UIStrings.infoThirdRow, subtitle: character.specie)
                    CharacterDetailInfoCellView(title: UIStrings.infoFourthRow, subtitle: character.status)
                }
            }
            
            if let location = viewModel.characterDetail?.location {
                Section(header: Text(UIStrings.locationSectionTitle)) {
                    CharacterDetailInfoCellView(title: UIStrings.locationFirstRow, subtitle: location.name)
                        .accessibilityIdentifier(UIStrings.listRowCharacterDetailIdentifier)
                    CharacterDetailInfoCellView(title: UIStrings.locationSecondRow, subtitle: location.dimension ?? Constants.unkwown)
                    CharacterDetailInfoCellView(title: UIStrings.locationThirdRow, subtitle: location.type ?? Constants.unkwown)
                }
            }
            
            if let origin = viewModel.characterDetail?.origin {
                Section(header: Text(UIStrings.originSectionTitle)) {
                    CharacterDetailInfoCellView(title: UIStrings.locationFirstRow, subtitle: origin.name)
                    CharacterDetailInfoCellView(title: UIStrings.locationSecondRow, subtitle: origin.dimension ?? Constants.unkwown)
                    CharacterDetailInfoCellView(title: UIStrings.locationThirdRow, subtitle: origin.type ?? Constants.unkwown)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(UIStrings.characterDetailNavigationTitle)
        .task {
            await viewModel.onAppear()
        }
    }
}

struct CharacterImageView: View {
    
    let url: String
    
    var body: some View {
        
        HStack {
            Spacer()
            KingFisherImageView(url: url, size: Constants.thumbnailDetailSize)
                .resizable()
                .frame(width: Constants.thumbnailDetailSize.width, height: Constants.thumbnailDetailSize.height)
            Spacer()
        }
        .listRowBackground(Color.mint.opacity(0.1))
    }
}

struct CharacterDetailInfoCellView: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        
        HStack {
            Text(title).bold()
            Spacer()
            Text(subtitle).foregroundStyle(.mint)
        }
    }
}

/*struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
    }
}*/
