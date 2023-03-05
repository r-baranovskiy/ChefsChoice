//
//  RecipesViewController.swift
//  ChefsChoice
//
//  Created by Nikolai Zvonarev on 01.03.2023.
//

import UIKit

final class RecipesViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let dataManager = RecipesManager()
    
    private var popularRecipes = [RecipeModel]()
    private var categoryRecipes = [RecipeModel]()
    private var randomRecipes = [RecipeModel]()
    
    private var sections: [SectionList] {
        [.popular(popularRecipes),
         .category(categoryRecipes),
         .random(randomRecipes)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        
        categoryRecipes = dataManager.categories
        
        dataManager.fetchRecipe(sort: .popularity) { result in
            switch result {
            case .success(let success):
                self.popularRecipes = success
                self.collectionView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        dataManager.fetchRecipe(sort: .random) { result in
            switch result {
            case .success(let success):
                self.randomRecipes = success
                self.collectionView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Chef's Choise"
        view.addSubview(collectionView)
        collectionView.register(
            PopularCollectionViewCell.self,
            forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(
            RandomCollectionViewCell.self,
            forCellWithReuseIdentifier: RandomCollectionViewCell.identifier)
        collectionView.register(
            HeaderSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: - Create Layout

extension RecipesViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else {return nil}
            let section = self.sections[sectionIndex]
            switch section {
            case .popular(_):
                return self.createPopularSection()
            case .category(_):
                return self.createCategorySection()
            case .random(_):
                return self.createRandomSection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup, behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, interGroupSpacing: CGFloat, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem], contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    // Popular
    private func createPopularSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.3)), subitems: [item])
        group.contentInsets.bottom = 16
        
        let section = createLayoutSection(
            group: group, behavior: .groupPaging, interGroupSpacing: 5,
            supplementaryItems: [supplementaryHeaderItem()], contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    // Category
    private func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .absolute(150)))
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 30
        
        return section
    }
    
    // Random
    private func createRandomSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 2
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .fractionalHeight(0.3)), subitems: [item])
        
        let section = createLayoutSection(
            group: group, behavior: .continuous, interGroupSpacing: 0,
            supplementaryItems: [supplementaryHeaderItem()], contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    // Header
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(20)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
}

//MARK: - UICollectionViewDelegate

extension RecipesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch sections[indexPath.section] {
        case .popular(_):
            let item = sections[indexPath.section].recipes[indexPath.row]
            print(item.title)
        case .category(_):
            print("category")
        case .random(_):
            print("random")
        }
    }
}

//MARK: - IUCollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .popular(let popular):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularCollectionViewCell.identifier,
                for: indexPath) as? PopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            dataManager.fetchImage(id: popularRecipes[indexPath.row].id,
                                   size: .size556x370) { image in
                DispatchQueue.main.async {
                    cell.addImageToCell(image: image)
                }
            }
            cell.configureCell(model: popular[indexPath.row])
            return cell
            
        case .category(let category):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.identifier,
                for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(categoryName: category[indexPath.row].title,
                               imageName: category[indexPath.row].image)
            return cell
            
        case .random(_):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RandomCollectionViewCell.identifier,
                for: indexPath) as? RandomCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            dataManager.fetchImage(id: randomRecipes[indexPath.row].id,
                                   size: .size636x393) { image in
                DispatchQueue.main.async {
                    cell.addImageToCell(image: image)
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView",
                for: indexPath) as? HeaderSupplementaryView else {
                return UICollectionReusableView()
            }
            header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

//MARK: - Set Constraints

extension RecipesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}