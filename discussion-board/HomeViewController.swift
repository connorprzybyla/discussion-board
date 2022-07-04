//
//  HomeViewController.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/3/22.
//

import SwiftUI

// MARK: - HomeViewController

class HomeViewController: UICollectionViewController {
    
    private static let cellID = "CellID"
    private var datasource: UICollectionViewDiffableDataSource<Section, String>?
    
    // MARK: - Initializers
    
    init() {
        super.init(collectionViewLayout: HomeViewController.configureLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureAutoLayout()
        createDatasource()
        reloadData()
    }
}

// MARK: - UICollectionView setup methods

extension HomeViewController {
    
    private static func configureLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 4, bottom: 4, trailing: 4
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(0.93),
                                  heightDimension: .estimated(200)),
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            return section
        }
    }
        
    private func configureCollectionView() {
        navigationItem.title = "Popular Topics"
        collectionView.register(
            UICollectionViewCell.self, forCellWithReuseIdentifier: Self.cellID
        )
        createDatasource()
        reloadData()
    }
    
    private func configureAutoLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - DataSource methods

extension HomeViewController {
    
    private func createDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { collectionView, indexPath, threadTitle in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Self.cellID, for: indexPath
            )
            cell.backgroundColor = .systemBlue
            return cell
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([Section.trending])
        snapshot.appendItems(["Cars", "Photograph", "Mechanical Keyboards", "Clothing"], toSection: .trending)
        datasource?.apply(snapshot)
    }
}

// MARK: - Preview Provider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: HomeViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        
        typealias UIViewControllerType = UIViewController
    }
}

struct ContentView: View {
    var body: some View {
        Text("discussion-board")
    }
}
