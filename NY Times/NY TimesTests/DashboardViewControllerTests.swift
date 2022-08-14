//
//  DashboardViewControllerTests.swift
//  NY TimesTests
//
//  Created by Mohamed Zaki on 14/08/2022.
//

import XCTest
@testable import NY_Times

class DashboardViewControllerTests: XCTestCase {
    var dashboardViewController: DashboardViewController!
    var viewModel: MockViewModel!
    override func setUp() {
        super.setUp()
        guard let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DashboardViewController") as? DashboardViewController else {return}
        dashboardViewController = dashboardVC
        viewModel = MockViewModel()
        dashboardViewController.configure(viewModel: viewModel)
        dashboardViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTableViewRowCount() {
        XCTAssertEqual(dashboardViewController.tableView.numberOfRows(inSection: 0), 1)
    }

    func testTableViewCells() {
        dashboardViewController.tableView.reloadData()
        guard let cell = dashboardViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NewsTableViewCell else {
            XCTFail("Cell not found")
            return
        }
        XCTAssertEqual(cell.title.text, "test_title")
    }

    func testDidSelect() {
        dashboardViewController.tableView(dashboardViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(viewModel.didSelect)
    }
}

class MockViewModel: DashboardViewModelProtocol {
    var hasError: Observable<Bool>?
    var didSelect = false
    var network: NetworkRequestProtocol?

    var dashboardDataModels: Observable<[NewsDataModel]>?

    func configure() {
        let model = NewsDataModel(source: nil, publishedDate: nil, section: nil, subSection: nil, byLine: nil, title: "test_title", abstract: nil, smallImageURL: nil, largeImageURL: nil)
        dashboardDataModels = Observable([model])
    }

    func didSelect(row: Int) {
        didSelect = true
    }

}
