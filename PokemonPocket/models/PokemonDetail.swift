//
//  PokemonDetail.swift
//  PokemonPocket
//
//  Created by Pooh on 21/6/2564 BE.
//

import UIKit

struct PokemonDetail {
    var height: Double?
    var weight: Double?
    var image: String?
    
    init(){
    }
    
    
    init(dict: Dictionary<String,AnyObject>) {
        height = dict["height"] as? Double
        weight = dict["weight"] as? Double
        if let dictSprites = dict["sprites"] as? Dictionary<String, AnyObject> {
            image = dictSprites["front_default"] as? String
        }
    }
}
