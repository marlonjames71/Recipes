//
//  MainViewController.swift
//  Recipes
//
//  Created by Marlon Raskin on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	// MARK: - Properties & Outlets

	let networkClient = RecipesNetworkClient()
	var allRecipes: [Recipe] = []
	var recipesTableViewController: RecipesTableViewController?

	var searchResults: [Recipe] = [] {
		didSet {
			recipesTableViewController?.recipes = searchResults
		}
	}

	@IBOutlet weak var searchBar: UISearchBar!


	// MARK: - Lifecycle

	override func viewDidLoad() {
        super.viewDidLoad()
		setUI()
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

	
	// MARK: - Search Function

	func filteredContentForSearchText(searchText: String) {
		if searchText != "" {
			searchResults = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
		} else {
			searchResults = allRecipes
		}
	}

	func setUI() {
		navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
		navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
	}
}

extension MainViewController: UISearchBarDelegate {

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard let searchInput = searchBar.text else { return }
		filteredContentForSearchText(searchText: searchInput)
	}
}
