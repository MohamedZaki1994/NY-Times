//
//  NavigationManager.swift
//  NY Times
//
//  Created by Mohamed Zaki on 12/08/2022.
//

import Foundation
import UIKit

class NavigationManager {
    private init() {}
    static let shared = NavigationManager()
    let navigation = UINavigationController()
    let factory = Factory()

    func next(currentFlow: Routes) {
        switch currentFlow {
        case .initial:
            guard let dashboard = factory.makeDashboardViewController() else {return}
            navigation.viewControllers = [dashboard]
        case .Dashboard(let model):
            guard let detailsVC = factory.makeDetailsViewController() else {return}
            let viewModel = DetailsViewModel(model: model)
            detailsVC.viewModel = viewModel
            navigation.pushViewController(detailsVC, animated: true)
        case .Details:
            break
        }
    }
}

enum Routes {
    case initial
    case Dashboard(model: DashboardDataModel)
    case Details
}
