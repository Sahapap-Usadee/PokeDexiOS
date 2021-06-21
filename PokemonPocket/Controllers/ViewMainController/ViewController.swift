//
//  ViewController.swift
//  PokemonPocket
//
//  Created by Pooh on 21/6/2564 BE.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var pokemonList: [Pokemon] = [] // init pokemon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTable()
        self.requestPokemon()
    }
    
    @IBOutlet weak var pokemonTable: UITableView!
    
    func setUpTable(){
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        pokemonTable.contentInset = UIEdgeInsets(top: 0, left: -14, bottom: 0, right: 0) // Offset Table
    }
    
    func requestPokemon(){
        AF.request("https://pokeapi.co/api/v2/pokemon/", method: .get, parameters: ["limit": "99", "offset": "0"], encoding: URLEncoding.default, headers: ["App-Id" : "996806944052152"]).responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let dictJson = json as? Dictionary<String, AnyObject> { // { }
                        if let arrJson = dictJson["results"] as? [Dictionary<String, AnyObject>] { // { {Results} }
                            self.pokemonList = [Pokemon]()
                            for i in 0..<arrJson.count {
                                self.pokemonList.append(Pokemon(dict: arrJson[i])) //add arraay
                                print(arrJson[i])
                            }
                            self.pokemonTable.reloadData()
                        }
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

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = PokemonController(nibName: "PokemonController", bundle: nil)
        viewController.name = pokemonList[indexPath.row].name ?? ""
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListPokemon", for: indexPath) as! CellPokemon
        cell.setUpCell(name: pokemonList[indexPath.row].name ?? "null")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.00
    }
    
}


