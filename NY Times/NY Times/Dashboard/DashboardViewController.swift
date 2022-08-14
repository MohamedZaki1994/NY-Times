//
//  DashboardViewController.swift
//  NY Times
//
//  Created by Mohamed Zaki on 10/08/2022.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DashboardViewModelProtocol?
    let nibId = "NewsTableViewCell"

    func configure(viewModel: DashboardViewModelProtocol) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel?.configure()
        viewModel?.dashboardDataModels?.bind({ [weak self] model in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        viewModel?.hasError?.bind({ [weak self] hasError in
            if hasError ?? false {
                self?.errorView()
            }
        })
    }

    func errorView() {
        let alert = UIAlertController(title: "Error", message: "couldn't load your content", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "try again", style: .default, handler: { [weak self] alertAction in
            self?.viewModel?.hasError?.value = false
            self?.viewModel?.configure()
        }))
        present(alert, animated: true, completion: nil)
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: nibId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibId)
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.dashboardDataModels?.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nibId, for: indexPath)
        guard let newsCell = cell as? NewsTableViewCell,
        let model = viewModel?.dashboardDataModels?.value else {
            return cell
        }
        newsCell.configure(imageName: model[indexPath.row].smallImageURL ?? "", title: model[indexPath.row].title, publishedDate: model[indexPath.row].publishedDate, section: model[indexPath.row].section)
        return newsCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(row: indexPath.row)
    }
}
