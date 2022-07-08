//
//  ThreadVC.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/7/22.
//

import UIKit

class ThreadVC: UIViewController {
    
    // MARK: UIView
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        let label = UILabel()
        label.text = "Welcome User!"
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        setupAutoLayout()
    }
    

}

// MARK: Auto Layout

extension ThreadVC {
    
    private func setupAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
