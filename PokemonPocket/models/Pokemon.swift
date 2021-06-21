//
//  Pokemon.swift
//  PokemonPocket
//
//  Created by Pooh on 21/6/2564 BE.
//

import UIKit

struct Pokemon {
    var name: String?
    var url: String?
    
    init(){
    }
    init(dict: Dictionary<String,AnyObject>) {
        name = dict["name"] as? String
        url = dict["url"] as? String
    }
}
//{
//            "name": "bulbasaur",
//            "url": "https://pokeapi.co/api/v2/pokemon/1/"
//}
