//
//  PokemonController.swift
//  PokemonPocket
//
//  Created by Pooh on 21/6/2564 BE.
//

import UIKit
import Alamofire

class PokemonController: UIViewController {
    var pokemonDetail : PokemonDetail = PokemonDetail()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHeigth: UILabel!
    @IBOutlet weak var lblWeigth1: UILabel!
    @IBOutlet weak var imvPokemon: UIImageView!
    
    var name : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestPokemonDetail()
    }
    
    
    func setUp(){
        lblName.text = name
        lblHeigth.text = "\(pokemonDetail.height ?? 0)"
        lblWeigth1.text = "\(pokemonDetail.weight ?? 0)"
        let url = URL(string: pokemonDetail.image!)
        let data = try? Data(contentsOf: url!)
        imvPokemon.image = UIImage(data: data!)
    }
    
    func requestPokemonDetail(){
        AF.request("https://pokeapi.co/api/v2/pokemon/\(name)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["App-Id" : "996806944052152"]).responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                   if let dictJson = json as? Dictionary<String, AnyObject> {
                    self.pokemonDetail = PokemonDetail(dict: dictJson)
                    print(self.pokemonDetail.image ??  "")
                    self.setUp()
                   }
                } catch _ as NSError {
                    print("fail")
                }
                break
            case .failure:
                print("Error")
            }
        }
    }

}




