//
//  ViewController.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit

final class QuotesListViewController: UIViewController {
    private let presenter: QuotesListPresenter
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    init(presenter: QuotesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setUpSearchController()
        setUpSearchControllerAppearance()
        setConstrains()
    }
}


//MARK: - Configure UiCollectionView
private extension QuotesListViewController{
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(QuatesListCell.self, forCellWithReuseIdentifier: QuatesListCell.resuseID)
    }
}

//MARK: - Configure SearchController
private extension QuotesListViewController{
    func setUpSearchControllerAppearance(){
        let textField = searchController.searchBar.searchTextField
        textField.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        textField.backgroundColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        textField.layer.cornerRadius = 15.0
        textField.clipsToBounds = true
        textField.leftView?.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        // Change color of placeholder text
        let attributedPlaceholder = NSAttributedString(string: "Search quote category", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)])
        textField.attributedPlaceholder = attributedPlaceholder
        
        let searchBar = searchController.searchBar
        searchBar.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) //apply for cancel button too
        searchBar.backgroundColor = .clear
        searchBar.layer.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        searchBar.layer.shadowOpacity = 1.0
        searchBar.layer.shadowRadius = 5.0
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchBar.layer.cornerRadius = 15.0
        searchBar.clipsToBounds = true
   }
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

//MARK: - SearchController
extension QuotesListViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        presenter.filterCategories(text: text)
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // dismiss keyBoard
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension QuotesListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.isFilter ? presenter.quatesListArrayFilter.count : presenter.quatesListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuatesListCell.resuseID, for: indexPath) as? QuatesListCell else { return UICollectionViewCell() }
        let data = presenter.isFilter ? presenter.quatesListArrayFilter[indexPath.row]: presenter.quatesListArray[indexPath.row]
        cell.configCell(categoryLabelText: data.category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = presenter.isFilter ? presenter.quatesListArrayFilter[indexPath.row]: presenter.quatesListArray[indexPath.row]
        presenter.routeToDetail(category: data.category)
    }
}

//MARK: - Set QuotesListVCProtocol
extension QuotesListViewController: QuotesListVCProtocol{
    func reload() {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension QuotesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // from left and right of the screen
        let minimumItemSpacing: CGFloat = 11 // between columns
        let availableWidth = view.bounds.width - (padding * 2) - (minimumItemSpacing)
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        11
    }
}
//MARK: - Set Constrains
private extension QuotesListViewController{
    func setConstrains(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
