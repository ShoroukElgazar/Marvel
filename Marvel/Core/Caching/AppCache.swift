//
//  AppCache.swift
//  Marvel
//
//  Created by Mac on 17/06/2023.
//

import Foundation

 final class AppCache<Key: Hashable, Value> {
    
    private let cache = NSCache<KeyWrapper, CacheEntry>()
    
    private final class CacheEntry {
       let value: Value
           
     init(value: Value) {
         self.value = value
     }
    }
    
    private final class KeyWrapper: NSObject {
        let key: Key
        
        init(_ key: Key) { self.key = key }
        
        override var hash: Int { key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? KeyWrapper else { return false }
            return value.key == key
        }
    }
}


 extension AppCache {
   
    func insert(_ value: Value, forKey key: Key) {
        let entry = CacheEntry(value: value)
        cache.setObject(entry, forKey: KeyWrapper(key))
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = cache.object(forKey: KeyWrapper(key)) else { return nil }
        return entry.value
    }

    func removeValue(forKey key: Key) {
        cache.removeObject(forKey: KeyWrapper(key))
    }
    
}


