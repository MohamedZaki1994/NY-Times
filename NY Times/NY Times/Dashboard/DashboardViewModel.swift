//
//  DashboardViewModel.swift
//  NY Times
//
//  Created by Mohamed Zaki on 10/08/2022.
//

import Foundation

class DashboardViewModel {
    var dashboardDataModel: Observable<[DashboardDataModel]>?
    let network = NetworkHandler()

    func configure() {
        var dataModel = [DashboardDataModel()]
        dashboardDataModel = Observable(dataModel)
        network.request(type: MostPopularModel.self) { [weak self] result in
            guard let self = self else { return }
            result.results.forEach { item in
                let model = DashboardDataModel(source: item.source.rawValue, publishedDate: item.publishedDate, section: item.section, byLine: item.byline, title: item.title, abstract: item.abstract, imageURL: item.media.first?.mediaMetadata.first?.url)
                dataModel.append(model)
            }
            self.dashboardDataModel?.value = dataModel
        }
    }
}

struct DashboardDataModel {
    var source: String?
    var publishedDate: String?
    var section: String?
    var byLine: String?
    var title: String?
    var abstract: String?
    var imageURL: String?
}
