//
//  UserViewController.swift
//  Marks-Example
//
//  Created by Sergey Biloshkurskyi on 11/3/17.
//  Copyright © 2017 Sergey Biloshkurskyi. All rights reserved.
//

import UIKit

protocol UserViewControllerDelegate {
    func update(_ user: User, score: Int)
    func remove(_ user: User)
}

class UserViewController: UIViewController {

    // MARK: - Constants
    static let identifier = "userVCIdentifier"
    
    // MARK: - Injections
    public var delegate: UserViewControllerDelegate?
    
    // MARK: - Instance Properties
    var user: User!
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = user.name
        }
    }
    @IBOutlet weak var scoreTextFierd: UITextField! {
        didSet {
            scoreTextFierd.placeholder = "From 0 to 100"
            scoreTextFierd.text = "\(user.score)"
            scoreTextFierd.becomeFirstResponder()
        }
    }

    // MARK: - Class Constructors
    static func customInit() -> UserViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: UserViewController.identifier) as! UserViewController
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func remove(_ sender: UIButton) {
        delegate?.remove(user)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    fileprivate func process(new score: String?) -> Bool {
        guard let score = score else { return false }
        if let newScore = Int(score), 0...100 ~= newScore {
            delegate?.update(user, score: newScore)
            self.navigationController?.popViewController(animated: true)
            return true
        }
        return false
    }
}

// MARK: - UITextFieldDelegate
extension UserViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if process(new: textField.text) {
            textField.resignFirstResponder()
            return true
        }
        
        textField.text = nil
        return false
    }
}
