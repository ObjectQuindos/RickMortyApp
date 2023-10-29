//
//  CacheRM.swift
//  RickAndMorty
//
//  Created by David López on 28/10/23.
//

import Foundation

class CacheManager<T: AnyObject> {
    
    private var cache: NSCache<AnyObject, AnyObject>
    
    init(cache: NSCache<AnyObject, AnyObject> = NSCache<AnyObject, AnyObject>(), name: String) {
        self.cache = cache
        self.name = name
    }
    
    var name: String {
        get { return self.cache.name }
        set { self.cache.name = newValue }
    }
    
    func objectFor(key: AnyObject) -> T? {
        self.cache.object(forKey: key) as? T
    }
    
    func setObject(object: T, forKey key: AnyObject) {
        self.cache.setObject(object, forKey: key)
    }
    
    func removeObjectFor(key: AnyObject) {
        self.cache.removeObject(forKey: key)
    }
    
    func flush() {
        self.cache.removeAllObjects()
    }
    
    subscript(key: AnyObject) -> T? {
        get {
            return self.cache.object(forKey: key) as? T
        }
        
        set {
            if let newValue = newValue {
                self.cache.setObject(newValue, forKey: key)
            } else {
                self.cache.removeObject(forKey: key)
            }
        }
    }
}
