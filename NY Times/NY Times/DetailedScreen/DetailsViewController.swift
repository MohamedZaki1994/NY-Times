//
//  DetailsViewController.swift
//  NY Times
//
//  Created by Mohamed Zaki on 12/08/2022.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailsDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var byLine: UILabel!
    @IBOutlet weak var subSection: UILabel!
    @IBOutlet weak var source: UILabel!

    @IBOutlet weak var subSectionStack: UIStackView!
    

    var viewModel: DetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        newsTitle.text = viewModel?.dashboardDataModel?.value?.title
        if let url = URL(string: viewModel?.dashboardDataModel?.value?.largeImageURL ?? "") {
            imageView.kf.setImage(with: url)
        }
        detailsDescription.text = viewModel?.dashboardDataModel?.value?.abstract
        date.text = viewModel?.dashboardDataModel?.value?.publishedDate
        section.text = viewModel?.dashboardDataModel?.value?.section
        subSection.text = viewModel?.dashboardDataModel?.value?.subSection
        subSectionStack.isHidden = subSection.text?.isEmpty ?? false
        byLine.text = viewModel?.dashboardDataModel?.value?.byLine
        source.text = viewModel?.dashboardDataModel?.value?.source

    }
}

class DetailsViewModel {
    var dashboardDataModel: Observable<DashboardDataModel>?

    init(model: DashboardDataModel) {
        dashboardDataModel = Observable(model)
    }
}
