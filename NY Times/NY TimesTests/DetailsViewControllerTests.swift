//
//  DetailsViewControllerTests.swift
//  NY TimesTests
//
//  Created by Mohamed Zaki on 14/08/2022.
//

import XCTest
@testable import NY_Times

class DetailsViewControllerTests: XCTestCase {

    var detailsVC: DetailsViewController!

    override func setUp() {
        super.setUp()
        let factory = Factory()
        detailsVC = factory.makeDetailsViewController()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDetailsViewControllerTitleLabel() {
        let model = NewsDataModel(source: "", publishedDate: "", section: "", subSection: "", byLine: "", title: "test_title", abstract: "", smallImageURL: "", largeImageURL: "")
        detailsVC.viewModel = DetailsViewModel(model: model)
        detailsVC.loadViewIfNeeded()
        XCTAssertEqual(detailsVC.newsTitle.text, model.title)
    }

}
