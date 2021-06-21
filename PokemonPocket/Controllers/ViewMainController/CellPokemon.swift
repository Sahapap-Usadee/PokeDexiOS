//
//  CellPokemon.swift
//  PokemonPocket
//
//  Created by Pooh on 21/6/2564 BE.
//

import UIKit

class CellPokemon: UITableViewCell {
    @IBOutlet weak var lblPokemonId: UILabel!
    @IBOutlet weak var lblPokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(name: String){
        lblPokemonId.text = "Pokemon"
        lblPokemonName.text = name
    }
}
