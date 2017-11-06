//
//  ScoreListViewController.swift
//  Marks-Example
//
//  Created by Sergey Biloshkurskyi on 11/3/17.
//  Copyright © 2017 Sergey Biloshkurskyi. All rights reserved.
//

import UIKit
import RealmSwift

class ScoreListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var missingResults: UIView! {
        didSet {
            missingResults.customize()
        }
    }
    
    // MARK: -
    fileprivate var service = StorageService()
    fileprivate var users: Results<User>!
    fileprivate var usersNotifications: NotificationToken?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        users = service.users()
        notifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func createDozenUsers(_ sender: Any) {
        service.add(new: User.dozenUser())
    }
    
    @IBAction func createUser(_ sender: Any) {
        service.add(new: [User.newUser()])
    }
    
    // MARK: - Private Methods
    fileprivate func updateViewsState() {
        if users.count > 0 {
            tableView.isHidden = false
            missingResults.isHidden = true
        } else {
             tableView.isHidden = true
             missingResults.isHidden = false
        }
    }
    
    fileprivate func notifications() {
        usersNotifications = users.addNotificationBlock { [weak self] changes in
            guard  let strongSelf = self, let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                strongSelf.updateViewsState()
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                strongSelf.updateViewsState()
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ScoreListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserViewController.customInit()
        vc.user = users[indexPath.row]
        vc.delegate = self
        self.navigationController?.show(vc, sender: self)
    }
}

// MARK: - UITableViewDataSource

extension ScoreListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        cell.configure(with: users[indexPath.row])
        return cell
    }
}

// MARK: - UserViewControllerDelegate
extension ScoreListViewController: UserViewControllerDelegate {
    func update(_ user: User, score: Int) {
        service.update(user, score: score)
    }
    func remove(_ user: User) {
        service.remove(user)
    }
}
