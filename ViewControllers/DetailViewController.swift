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
		setUI()
		updateViews()
		title = "Instructions"
    }

	func updateViews() {
		loadViewIfNeeded()
		guard let recipe = recipe else { return }
		recipeNameLabel.text = recipe.name
		recipeTextView.text = recipe.instructions
	}

	func setUI() {
		navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
		navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
	}
}
