//
//  ContentViewModel.swift
//  RickAndMorty
//
//  Created by David López on 22/10/23.
//

import Foundation

final class ListCharactersViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let interactor = CharactersInteractor()
    @Published var characterList: [CharacterModel] = []
    
    private var pageNumber = 1
    private var isPaginating = false
    var hasNextPagination = false
    
    // MARK: - Public API
    
    func onAppear() async {
        await getAllCharactersInfo()
    }
    
    // MARK: - Interactor
    
    private func getAllCharactersInfo() async {
        do {
            let allCharacters = try await interactor.getAllCharacters(pageNumber: pageNumber)
            
            DispatchQueue.main.async {
                self.hasNextPagination = allCharacters.info.next != nil
                let characters: [CharacterModel] = allCharacters.results.compactMap { .init(from: $0) }
                self.characterList += characters
                self.isPaginating = false
            }
            
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func loadMoreItems() async {
        guard hasNextPagination else { return }
        guard !isPaginating else { return }
        
        pageNumber += 1
        isPaginating = true
        await getAllCharactersInfo()
    }
}
