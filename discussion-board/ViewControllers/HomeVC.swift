//
//  HomeVC.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/3/22.
//

import SwiftUI

// MARK: - HomeVC

class HomeVC: UICollectionViewController {
    
    private let sections = Bundle.main.decode([Section].self, from: "Threads.json")
    private static let cellID = "CellID"
    private var datasource: UICollectionViewDiffableDataSource<Section, Thread>?
    
    // MARK: - Initializers
    
    init() {
        super.init(collectionViewLayout: HomeVC.configureLayout())
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

// MARK: - UICollectionView Layout

extension HomeVC {
    
    private static func configureLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            if sectionIndex == 0 {
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
            } else if sectionIndex == 1 {
                let configuration = UICollectionLayoutListConfiguration(
                    appearance: .insetGrouped
                )
                return NSCollectionLayoutSection.list(
                    using: configuration,
                    layoutEnvironment: environment
                )
            }
            
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 20, bottom: 4, trailing: 20
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .estimated(200)),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
        
    private func configureCollectionView() {
        navigationItem.title = "Popular Topics"
        collectionView.register(
            ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier
        )
        collectionView.register(
            FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier
        )
        collectionView.register(
            NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.reuseIdentifier
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

// MARK: - DataSource

extension HomeVC {
    
    private func createDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, Thread>(collectionView: collectionView) { collectionView, indexPath, thread in
            switch self.sections[indexPath.section].type {
            case "list":
                return self.configure(ListCell.self, with: thread, for: indexPath)
            case "featured":
                return self.configure(FeaturedCell.self, with: thread, for: indexPath)
            default:
                return self.configure(NormalCollectionViewCell.self, with: thread, for: indexPath)
            }
        }
    }
    
    private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with thread: Thread, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: thread)
        return cell
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Thread>()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        datasource?.apply(snapshot)
    }
}

// MARK: UICollectionViewDelegate

extension HomeVC {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let threadVC = ThreadVC(
            threadTitle: self.sections[indexPath.section].items[indexPath.row].name,
            comments: self.sections[indexPath.section].items[indexPath.row].comments
        )
        navigationController?.pushViewController(threadVC, animated: false)
    }
}

// MARK: - Preview Provider

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: HomeVC())
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
