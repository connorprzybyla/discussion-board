//
//  ThreadVC.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/7/22.
//

import UIKit

class ThreadVC: UIViewController {
    
    // MARK: - Private variables
    
    private let threadTitle: String
    private let comments: [Comment]
    private var organizedComments: [(Comment, Int)] = []
    private static let cellID = "CellID"
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()
    
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
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        setupAutoLayout()
        sortComments(comments)
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

// MARK: UITableViewDataSource

extension ThreadVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizedComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellID, for: indexPath) as! CommentCell
        let commentViewModel = CommentViewModel(
            likeTotal: 100,
            dislikeTotal: 2,
            commentDescription: organizedComments[indexPath.row].0.description,
            indentationLevel: organizedComments[indexPath.row].1
        )
        cell.configure(with: commentViewModel)
        return cell
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension ThreadVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("Prefetching rows \(indexPaths.indices)")
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Canceling prefetching for rows \(indexPaths.indices)")
    }
}

// MARK: - Comments

extension ThreadVC {
    
    static func getReplies(for comment: Comment,
                           _ height: Int,
                           _ comments: inout [(Comment, Int)]) {
        comments.append((comment, height))
        for comment in comment.comments {
            Self.getReplies(for: comment, height + 1, &comments)
        }
    }
    
    func sortComments(_ comments: [Comment]) {
        for comment in comments {
            Self.getReplies(for: comment, 1, &organizedComments)
        }
        organizedComments.sort {
            $0.0.replyTo < $1.0.replyTo
        }
    }
}
