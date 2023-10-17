//
//  ViewController.swift
//  VitorMagalhaes_RM84808_Modelo3
//
//  Created by Usuário Convidado on 17/10/23.
//

import UIKit

var navi:UmaNavi!=nil

class ViewController: UIViewController {
    
    
    @IBOutlet weak var naviNome: UILabel!
    @IBOutlet weak var naviModelo: UILabel!
    @IBOutlet weak var criadorName: UILabel!
    @IBOutlet weak var txtNavi: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func exibir(_ sender: Any) {
        if txtNavi.text != ""{
            loadNavi()
        }
    }    
    
    func loadNavi(){
        let jsonUrlString = "https://swapi.dev/api/starships/" + txtNavi.text!.lowercased()
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {return}
            
            do{
                navi = try JSONDecoder().decode(UmaNavi.self, from: data)
                DispatchQueue.main.sync {
                    self.naviNome.text = navi.name
                    self.naviModelo.text = navi.model
                    self.criadorName.text = navi.manufacturer
                }
                

            }catch let jsonError{
                print("Erro da serialização do json", jsonError)
            }
        }
        .resume()
    }
    
    func carregarImagem(urlImagem:String)->UIImage?{
        var image:UIImage? = nil
        guard let url = URL(string: urlImagem)
        else
        {
            print("Não foi possível criar a URL")
            return nil
        }
        do{
            let data = try Data(contentsOf: url)
            image = UIImage(data: data)
        }catch{
            print(error.localizedDescription)
        }
        return image
    }


}

