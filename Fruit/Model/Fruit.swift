//
//  Fruit.swift
//  Fruit
//
//  Created by George McDonnell on 20/04/2017.
//  Copyright © 2017 George McDonnell. All rights reserved.
//

import UIKit
import SwiftyJSON

/**
 A fruit object that encapsulates data about a type of fruit
 */
class Fruit {

    /** The type of fruit */
    let type: String!
    
    /** The price of an item of the fruit */
    let price: String!
    
    /** The weight of of an item of the fruit */
    let weight: String!
    
    /**
     An initialiser for the fruit object
     
     - parameter type: The type of fruit
     - parameter price: The price of an item of the fruit
     - parameter weight: The weight of of an item of the fruit
     */
    init(type: String, price: String, weight: String) {
        self.type = type
        self.price = price
        self.weight = weight
    }
    
    /** Key for accessing fruit array */
    private static let FruitKey  = "fruit"
    
    /** Key for accessing type from a fruit dictionary */
    private static let TypeKey   = "type"
    
    /** Key for accessing weight from a fruit dictionary */
    private static let WeightKey = "weight"
    
    /** Key for accessing price from a fruit dictionary */
    private static let PriceKey  = "price"
    
    /**
     Initialises from a JSON object and returns an array of [Fruit]
     
     - parameter json: The JSON object to parse
     - returns: [Fruit] if the JSON was valid
     */
    static func parse (_ json : JSON) -> [Fruit]? {
        
        guard let apiFruit = json[FruitKey].array else {
            return nil
        }
        
        var fruits = [Fruit]()
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencySymbol = "£"
        numberFormatter.numberStyle = .currency
        
        for thisFruit in apiFruit {
            guard let type = thisFruit[TypeKey].string?.capitalized else {
                continue
            }

            guard let weight = thisFruit[WeightKey].float else {
                continue
            }

            let formattedWeight = formatWeight(weight)

            guard let pence = thisFruit[PriceKey].float else {
                continue
            }

            guard let formattedPrice = formatPrice(pence, numberFormatter: numberFormatter) else {
                continue
            }

            let fruit = Fruit(type: type, price: formattedPrice, weight: formattedWeight)
            fruits.append(fruit)
        }
        
        return fruits
    }
    
    /**
     Converts a given weight in grams into kilograms and formats into a String
     
     - parameter weight: A weight in grams
     - returns: A weight in kilograms formatted into a String
     */
    private static func formatWeight(_ weight: Float) -> String {
        return "\(weight / 1000)kg"
    }
    
    /**
     Converts a given price in pence into pounds and pence and formats into a String
     
     - parameter value: A price in pence
     - returns: A price in pounds and pence formatted into a String
     */
    private static func formatPrice(_ value: Float, numberFormatter: NumberFormatter) -> String?  {
        let number = NSNumber(value: value / 100)
        return numberFormatter.string(from: number)
    }
    
}
