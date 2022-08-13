//
//  DashboardViewController.swift
//  NY Times
//
//  Created by Mohamed Zaki on 10/08/2022.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = DashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        viewModel.configure()
        viewModel.dashboardDataModels?.bind({ [weak self] model in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dashboardDataModels?.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath)
        guard let newsCell = cell as? NewsTableViewCell,
        let model = viewModel.dashboardDataModels?.value else {
            return cell
        }
        newsCell.configure(imageName: model[indexPath.row].smallImageURL ?? "", title: model[indexPath.row].title, publishedDate: model[indexPath.row].publishedDate, section: model[indexPath.row].section)
        return newsCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(row: indexPath.row)
    }
}

