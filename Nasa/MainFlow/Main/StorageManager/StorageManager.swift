//
//  StorageManager.swift
//  Nasa
//
//  Created by kairzhan on 7/27/21.
//

import UIKit
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func savePhotos(_ photos: [Photo]) {
        try! realm.write {
            realm.add(photos)
        }
    }
    
    static func deletePhotos(_ photos: Results<Photo>) {
        try! realm.write {
            realm.delete(photos)
        }
    }
    
    static func deletePhoto(_ photo: Photo) {
        try! realm.write {
            realm.delete(photo)
        }
    }

}
