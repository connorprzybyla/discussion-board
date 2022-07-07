//
//  ListCell.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/6/22.
//

import UIKit

class ListCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier = "ListCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private let name = UILabel()
    private let subtitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with thread: Thread) {
        name.text = thread.name
        subtitle.text = thread.subtitle
    }
    
    private func setupCell() {
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(subtitle)
        contentView.addSubview(stackView)
        contentView.backgroundColor = .systemGray5
    }
    
    private func autoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
