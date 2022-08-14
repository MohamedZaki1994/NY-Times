//
//  DashboardViewModel.swift
//  NY Times
//
//  Created by Mohamed Zaki on 10/08/2022.
//

import Foundation

protocol DashboardViewModelProtocol {
    var network: NetworkRequestProtocol? { get set }
    var dashboardDataModels: Observable<[NewsDataModel]>? { get set }
    var hasError: Observable<Bool>? { get set }
    func configure()
    func didSelect(row: Int)
}

class DashboardViewModel: DashboardViewModelProtocol {

    var dashboardDataModels: Observable<[NewsDataModel]>?
    var hasError: Observable<Bool>? = Observable(false)
    var network: NetworkRequestProtocol?
    var dataModel: [NewsDataModel]?

    init(network: NetworkRequestProtocol) {
        self.network = network
        dataModel = [NewsDataModel]()
        dashboardDataModels = Observable(dataModel)
    }

    func configure() {
        network?.request(type: MostPopularModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                result.results.forEach { item in
                        let model = NewsDataModel(source: item.source.rawValue, publishedDate: item.publishedDate, section: item.section, subSection: item.subsection, byLine: item.byline, title: item.title, abstract: item.abstract, smallImageURL: item.media.first?.mediaMetadata.first?.url, largeImageURL: item.media.first?.mediaMetadata.last?.url)
                    self.dataModel?.append(model)
                    }
                self.dashboardDataModels?.value = self.dataModel
            case .failure:
                self.hasError?.value = true
            }
        }
    }

    func didSelect(row: Int) {
        guard let model = dashboardDataModels?.value?[row] else {return}
        NavigationManager.shared.next(currentFlow: .Dashboard(model: model))
    }
}
