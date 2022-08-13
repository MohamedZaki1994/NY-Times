//
//  Factory.swift
//  NY Times
//
//  Created by Mohamed Zaki on 12/08/2022.
//

import UIKit

class Factory {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func makeDashboardViewController() -> DashboardViewController? {
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
        return dashboardVC
    }

    func makeDetailsViewController() -> DetailsViewController? {
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        return detailsVC
    }
}
