//
//  ViewModel.swift
//  recipepuppy
//
//  Created by Martin Vega on 30/07/2019.
//  Copyright © 2019 Martin Vega. All rights reserved.
//  En el ViewModel configuracion de la conexión (binding) entre la capa Vista y los Datos, mediante observadores.

import RxSwift
import RxCocoa

class ViewModel {
    let searchBarObservable: Observable<String>
    let recipesObservable: Observable<[Recipe]>

    let firstPageRecipes: Observable<[Recipe]>
    let secondPageRecipes: Observable<[Recipe]>
    
    init(searchBarObservable: Observable<String>) {
        self.searchBarObservable = searchBarObservable
        
        firstPageRecipes = ViewModel.recipesObservable(with: self.searchBarObservable, at: 1)
        secondPageRecipes = ViewModel.recipesObservable(with: self.searchBarObservable, at: 2)
        
        recipesObservable = Observable.combineLatest(firstPageRecipes, secondPageRecipes) { first, second in
            var total = first
            total.append(contentsOf: second)
            return total
        }        
    }
    
    static func recipesObservable(with searchBarObservable: Observable<String>, at page: Int) -> Observable<[Recipe]> {
        let baseURLString = "http://www.recipepuppy.com/api/"

        return searchBarObservable
            .filter { $0.characters.count > 0 }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map { query -> URLRequest in
                var apiURL = URLComponents(string: baseURLString)!
                apiURL.queryItems = [
                    URLQueryItem(name: "q", value: query),
                    URLQueryItem(name: "p", value: String(page))
                ]
                print(apiURL.host!)
                return URLRequest(url: apiURL.url!)
            }
            .flatMapLatest { request -> Observable<Data> in
                return URLSession.shared.rx.data(request: request)
                    .catchErrorJustReturn(Data())
            }
            .map { data -> [Recipe] in
                let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
                return response.results
        }
    }
}
