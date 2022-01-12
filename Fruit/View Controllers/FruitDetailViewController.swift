//
//  FruitDetailViewController.swift
//  Fruit
//
//  Created by George McDonnell on 20/04/2017.
//  Copyright © 2017 George McDonnell. All rights reserved.
//

import UIKit

/**
 Displays details of a given fruit type
 */
class FruitDetailViewController: DisplayTimeViewController {

    /** A label to display the price of a fruit type */
    @IBOutlet private weak var priceLabel: UILabel!
    
    /** A label to display the weight of a fruit type */
    @IBOutlet private weak var weightLabel: UILabel!
    
    /** The fruit */
    var fruit: Fruit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = fruit?.type
        priceLabel.text = fruit?.price
        weightLabel.text = fruit?.weight
    }

}
