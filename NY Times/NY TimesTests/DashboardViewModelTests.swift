//
//  DashboardViewModelTests.swift
//  NY TimesTests
//
//  Created by Mohamed Zaki on 13/08/2022.
//

import XCTest
@testable import NY_Times
class DashboardViewModelTests: XCTestCase {

    var viewModel: DashboardViewModel?
    var mockNetwork: MockNetworkHandler!
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkHandler()
        viewModel = DashboardViewModel(network: mockNetwork)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDataModelFilling() {
        viewModel?.configure()
        XCTAssertEqual(viewModel?.dashboardDataModels?.value?.first?.title, "first Title")
    }
}

class MockNetworkHandler: NetworkRequestProtocol {

    func request<T: Codable>(type: T.Type, completion: ((Result<T, Error>) -> Void)?) {
        let result1 = NewsResult(uri: "", url: "", id: 0, assetID: 0, source: .newYorkTimes, publishedDate: "", updated: "", section: "", subsection: "", nytdsection: "", adxKeywords: "", column: nil, byline: "", type: .article, title: "first Title", abstract: "", desFacet: [""], orgFacet: [""], perFacet: [""], geoFacet: [""], media: [Media(type: .image, subtype: .photo, caption: "", copyright: "", approvedForSyndication: 0, mediaMetadata: [MediaMetadatum(url: "", format: .mediumThreeByTwo210, height: 0, width: 0)])], etaID: 0)
        let model = MostPopularModel(status: "", copyright: "", numResults: 1, results: [result1])
        guard let model = model as? T else {return}
        completion?(.success(model))
    }
}
