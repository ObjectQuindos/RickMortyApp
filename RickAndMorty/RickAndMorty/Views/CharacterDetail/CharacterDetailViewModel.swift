//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by David López on 25/10/23.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let interactor = CharactersInteractor()
    let cacheManager = CacheManager<CharacterDetailModel>(name: Constants.cacheName)
    
    @Published var characterDetail: CharacterDetailModel?
    
    // MARK: - Init
    
    init(character: CharacterModel) {
        self.characterDetail = CharacterDetailModel(with: character)
    }
    
    // MARK: - Public Functions
    
    func onAppear() async {
        await processData()
    }
    
    private func processData() async {
        let key = NSString(string: String(characterDetail!.character.id))
        
        if isObjectShownByCache(key: key) {
            return
        }
        
        await shownByService()
        cacheManager.setObject(object: characterDetail!, forKey: key)
    }
    
    // MARK: - Cache
    
    private func isObjectShownByCache(key: NSString) -> Bool {
        
        if let obj = cacheManager.objectFor(key: key) {
            
            DispatchQueue.main.async {
                self.characterDetail?.location = obj.location
                self.characterDetail?.origin = obj.origin
            }
            
            return true
        }
        
        return false
    }
    
    // MARK: - Interactor
    
    private func shownByService() async {
        
        let locationModel: LocationModel?
        let originModel: OriginModel?
        
        (locationModel, originModel) =  await (getLocation(), getOrigin())
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.characterDetail?.location = locationModel
            self.characterDetail?.origin = originModel
        }
    }
    
    private func getLocation() async -> LocationModel? {
        
        do {
            if let id = characterDetail?.character.location?.url.last {
                let location = try await interactor.getLocation(id: String(id))
                return LocationModel(from: location)
                
            } else {
                return nil
            }
            
        } catch let error {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getOrigin() async -> OriginModel? {
        
        do {
            if let id = characterDetail?.character.origin?.url.last {
                let origin = try await interactor.getOrigin(id: String(id))
                return OriginModel(from: origin)
                
            } else {
                return nil
            }
            
        } catch let error {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
}
