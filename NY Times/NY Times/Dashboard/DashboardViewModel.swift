//
//  DashboardViewModel.swift
//  NY Times
//
//  Created by Mohamed Zaki on 10/08/2022.
//

import Foundation

class DashboardViewModel {
    var dashboardDataModels: Observable<[DashboardDataModel]>?
    let network = NetworkHandler()

    func configure() {
        var dataModel = [DashboardDataModel]()
        dashboardDataModels = Observable(dataModel)
        network.request(type: MostPopularModel.self) { [weak self] result in
            guard let self = self else { return }
            result.results.forEach { item in
                let model = DashboardDataModel(source: item.source.rawValue, publishedDate: item.publishedDate, section: item.section, subSection: item.subsection, byLine: item.byline, title: item.title, abstract: item.abstract, smallImageURL: item.media.first?.mediaMetadata.first?.url, largeImageURL: item.media.first?.mediaMetadata.last?.url)
                dataModel.append(model)
            }
            self.dashboardDataModels?.value = dataModel
        }
    }

    func didSelect(row: Int) {
        guard let model = dashboardDataModels?.value?[row] else {return}
        NavigationManager.shared.next(currentFlow: .Dashboard(model: model))
    }
}

struct DashboardDataModel {
    var source: String?
    var publishedDate: String?
    var section: String?
    var subSection: String?
    var byLine: String?
    var title: String?
    var abstract: String?
    var smallImageURL: String?
    var largeImageURL: String?
}
