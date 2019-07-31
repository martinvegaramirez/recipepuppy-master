//
//  RecipeResponse.swift
//  recipepuppy
//
//  Created by Martin Vega on 30/07/2019.
//  Copyright © 2019 Martin Vega. All rights reserved.
//  Los datos de la respuesta del  Web Service 

import Foundation

class RecipeResponse: Codable {
    let version: Double
    let title: String
    let href: String
    let results: [Recipe]
}
