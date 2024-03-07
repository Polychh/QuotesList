//
//  FavoritiesViewController.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit

class FavoritiesViewController: UIViewController {
    private let presenter: FavoritiesPresenterProtocol
    
    private let tableView = UITableView()
    private let deleteButton = UIButton()
    
    init(presenter: FavoritiesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPButtons()
        configureTableView()
        setConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getSaveQuotes()
    }
}

//MARK: - Configure UIElements
private extension FavoritiesViewController{
     func configureTableView() {
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.resuseID)
    }
    func setUPButtons(){
        configButton(button: deleteButton, title: "DELETE")
        deleteButton.addTarget(nil, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    @objc func deleteTapped(){
        presenter.deleteAllFavs()
    }
    
    func configButton(button: UIButton, title: String){
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoritiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.saveQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.resuseID, for: indexPath) as? FavoriteCell else {return UITableViewCell()}
        let data = presenter.saveQuotes[indexPath.row]
        cell.selectionStyle = .none
        cell.configCell(quoteText: data.quoteText ?? "", author: data.author ?? "", category: data.category ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          let data = presenter.saveQuotes[indexPath.row]
          presenter.deleteOneItem(textQuote: data.quoteText ?? "")
          tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}

//MARK: - Set FavoritiesVCProtocol
extension FavoritiesViewController: FavoritiesVCProtocol{
    func reloadTableView() {
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}

//MARK: - Set Constrains
private extension FavoritiesViewController{
    func setConstrains(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor,constant: -16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 100),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
}
