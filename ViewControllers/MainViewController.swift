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
	let searchController = UISearchController()
	var searchResults: [Recipe] = [] {
		didSet {
			recipesTableViewController?.recipes = searchResults
		}
	}

	@IBOutlet weak var searchBar: UISearchBar!

	override func viewDidLoad() {
        super.viewDidLoad()
		networkClient.fetchRecipes { (recipes, error) in
			if let error = error {
				NSLog("Error fetching recipes: \(error)")
				return
			} else {
				guard let recipes = recipes else { return }
				self.allRecipes = recipes
				self.recipesTableViewController?.recipes = self.allRecipes
			}
		}
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "TableViewEmbedSegue" {
			recipesTableViewController = segue.destination as? RecipesTableViewController

		}
    }

	func filteredContentForSearchText(searchText: String) {
		if searchText != "" {
			searchResults = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
		} else {

		}
	}
}

extension MainViewController: UISearchBarDelegate {

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard let searchInput = searchBar.text else { return }
		filteredContentForSearchText(searchText: searchInput)
	}
}
