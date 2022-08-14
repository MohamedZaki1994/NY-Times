//
//  DetailsViewModel.swift
//  NY Times
//
//  Created by Mohamed Zaki on 14/08/2022.
//

import Foundation

class DetailsViewModel {
    var dashboardDataModel: Observable<NewsDataModel>?

    init(model: NewsDataModel) {
        dashboardDataModel = Observable(model)
    }
}
