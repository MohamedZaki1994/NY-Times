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
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        viewModel.configure()
        viewModel.dashboardDataModel?.bind({ model in
           print(model)
        })
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath)
        guard let newsCell = cell as? NewsTableViewCell else {
            return cell
        }
        return newsCell
    }
}

