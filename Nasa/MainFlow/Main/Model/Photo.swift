//
//  Photo.swift
//  Nasa
//
//  Created by kairzhan on 7/27/21.
//

import RealmSwift

class Photo: Object, Codable {
    @objc dynamic var img_src: String
}
