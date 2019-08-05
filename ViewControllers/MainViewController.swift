//
//  MainViewController.swift
//  Recipes
//
//  Created by Marlon Raskin on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	let networkClient = RecipesNetworkClient()
	var allRecipes: [Recipe] = []
	var recipesTableViewController: RecipesTableViewController?
	var filteredRecipes: [Recipe] = []

	@IBOutlet weak var searchBar: UISearchBar!

	override func viewDidLoad() {
        super.viewDidLoad()

		networkClient.fetchRecipes { (receipes, error) in
			if let error = error {
				NSLog("Error fetching recipes: \(error)")
				return
			}
			DispatchQueue.main.async {
				guard let recipes = receipes else { return }
				self.allRecipes = recipes
			}
		}
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "TableViewEmbedSegue" {
			recipesTableViewController = segue.destination as? RecipesTableViewController
		}
    }

//	private func filteredRecipes() {
//
//	}
}

extension MainViewController: UISearchBarDelegate {

}
