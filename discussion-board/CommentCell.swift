//
//  CommentCell.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/18/22.
//

import UIKit

// MARK: - CommentCellConfigurable

protocol CommentCellConfigurable {
    func configure(with viewModel: CommentViewModelable)
}

// MARK: - CommentCell

class CommentCell: UITableViewCell, CommentCellConfigurable {
    
    // MARK: - Private
    
    private let commentDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue", size: 18)
        return label
    }()
    
    private let likeButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    private let dislikeButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let votesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Lifecycle methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerStackView.addArrangedSubview(commentDescription)
        votesStackView.addArrangedSubview(likeButton)
        votesStackView.addArrangedSubview(dislikeButton)
        containerStackView.addArrangedSubview(votesStackView)
        contentView.addSubview(containerStackView)
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        commentDescription.text = nil
        likeButton.configuration?.title = nil
        dislikeButton.configuration?.title = nil
    }
    
    func configure(with viewModel: CommentViewModelable) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.likeButton.configuration?.title = String("Likes: \(viewModel.likeTotal)")
            strongSelf.dislikeButton.configuration?.title = String("Dislikes: \(viewModel.dislikeTotal)")
            strongSelf.commentDescription.text = viewModel.commentDescription
            print("Cell identation level is \(viewModel.indentationLevel)")
            strongSelf.indentationLevel = viewModel.indentationLevel
        }
    }
    
    // MARK: - Auto Layout
    
    private func configureAutoLayout() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
