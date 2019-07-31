//
//  Recipe.swift
//  recipepuppy
//
//  Created by Martin Vega on 30/07/2019.
//  Copyright © 2019 Martin Vega. All rights reserved.
//  Los datos de la receta

import Foundation

class Recipe: Codable {
    let title: String
    let href: URL
    let ingredients: String
    let thumbnail: String
}
