//
//  DetailViewController.swift
//  Recipes
//
//  Created by Marlon Raskin on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


	var recipe: Recipe? {
		didSet {
			updateViews()
		}
	}

	@IBOutlet weak var recipeNameLabel: UILabel!
	@IBOutlet weak var recipeTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
		updateViews()
    }

	func updateViews() {
		loadViewIfNeeded()
		guard let recipe = recipe else { return }
		recipeNameLabel.text = recipe.name
		recipeTextView.text = recipe.instructions
	}
}
