//
//  ThreadVC.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/7/22.
//

import UIKit

class ThreadVC: UIViewController {
    
    private let threadTitle: String
    private let comments: [Comment]
    private static let cellID = "CellID"
    private let tableView = UITableView()
    
    // MARK: - Initializers
    
    init(
        threadTitle: String,
        comments: [Comment]
    ) {
        self.threadTitle = threadTitle
        self.comments = comments
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellID)
        tableView.dataSource = self
        view.addSubview(tableView)
        setupAutoLayout()
    }
}

// MARK: Auto Layout

extension ThreadVC {
    
    private func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ThreadVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellID, for: indexPath)
        cell.textLabel?.text = comments[indexPath.row].description
        cell.indentationLevel = indexPath.row
        return cell
    }
}
