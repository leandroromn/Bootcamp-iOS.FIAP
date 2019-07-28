//
//  JokesViewController.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Leandro Romano on 27/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController {

    var category: String?
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - View Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let category = category {
            title = category
            activityIndicator.startAnimating()
            requestJokeFor(category: category)
        }
    }
    
    // MARK: - Setup View
    
    fileprivate func requestJokeFor(category categoryName: String) {
        let jokeUrl = Constants.jokesUrl + categoryName
        NetworkProvider.shared.request(jokeUrl) { [weak self] (response: Result<Joke, NetworkError>) in
            if case .success(let joke) = response {
                DispatchQueue.main.async {
                    self?.setupView(joke)
                }
            }
            
            if case .failure(let error) = response {
                DispatchQueue.main.async {
                    self?.displayAlert(Constants.titleErrorLabel, message: error.localizedDescription)
                }
            }
        }
    }
    
    fileprivate func setupView(_ joke: Joke) {
        activityIndicator.stopAnimating()
        jokeLabel.text = joke.message
    }

}
