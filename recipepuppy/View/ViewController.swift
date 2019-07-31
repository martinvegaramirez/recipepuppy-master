//
//  ViewController.swift
//  recipepuppy
//
//  Created by Martin Vega on 30/07/2019.
//  Copyright © 2019 Martin Vega. All rights reserved.
//  La capa vista, conexion de los views y activacion del ViewModel 

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    let cellIdentifier = "recipeCellIdentifier"
    var viewModel: ViewModel!
    //Coleccion de colores a ocupar para fondo en el tableview
    let bgColors : [UIColor] = [.red, .blue, .gray, .white, .brown, .cyan, .green, .yellow, .orange, .magenta, .purple, .lightGray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        viewModel = ViewModel(searchBarObservable: searchBar.rx.text.orEmpty.asObservable())
        viewModel.recipesObservable.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)) { (row, recipe, cell) in
            cell.textLabel?.text = recipe.title
            cell.detailTextLabel?.text = recipe.ingredients
            //Define color de acuerdo a el numero ingredientes
           let backColor =  recipe.ingredients.components(separatedBy:",")
            var indexColor = backColor.count
            if indexColor > 11 {
                indexColor = 11
            }
            print(indexColor)
            cell.backgroundColor? =  self.bgColors[indexColor]
            print(cell.backgroundColor)
            print(recipe.href.absoluteString)
            if recipe.href != nil {
                cell.accessibilityLabel = recipe.href.absoluteString
            } else {
                cell.accessibilityLabel =  "http://www.recipepuppy.com"
            }
        
            if recipe.thumbnail != "" {
                let url = URL(string: recipe.thumbnail)
                let data = try? Data(contentsOf: url!)
                cell.imageView?.image = UIImage(data: data!)
            }
            cell.selectionStyle = .none
            
        }.addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Posicion")
        print(indexPath)
        let details = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showDetails", sender: details)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? detailsViewController {
            if sender != nil {
                if  let details = sender as? UITableViewCell {
                    detailVC.details = details
                }
            }
            
        }
    }
    

}

extension ViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}







