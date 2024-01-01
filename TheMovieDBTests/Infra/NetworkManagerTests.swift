//
//  NetworkManagerTests.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 31/12/2023.
//

import XCTest
@testable import TheMovieDB

class NetworkManagerTests: XCTestCase {
    let anyUrl = "www.abc.xyz"
    let successResponse =  HTTPURLResponse(url: URL(string:"") ?? URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)
    
    func test_loadData_shouldPassCorrectValuesToHTTPClient() {
        let httpClient = HttpClientSpy()
        let parameters = ["key1": "value1", "key2": "value2"]
        let httpMethod: HTTPMethod = .get
        let headers = ["password": "12345"]
        let sut = NetworkManager(httpClient: httpClient, baseUrl: anyUrl)
        let testUrl1 = "testUrl1"
        sut.load(urlPath: testUrl1, httpMethod: httpMethod, parameters: parameters, headers: headers) { (mockedDTO: MockedDTO) in
            
        } failure: { (failureModel: NetworkFailure<MockedNetworkFailureModel>) in
            
        }
        XCTAssertEqual(anyUrl+testUrl1, httpClient.url)
        XCTAssertEqual(httpMethod, httpClient.httpMethod)
        XCTAssertEqual(parameters, httpClient.parameters as! [String: String])
        XCTAssertEqual(headers, httpClient.headers)
        
        trackForMemoryLeaks(httpClient)
        trackForMemoryLeaks(sut)
    }
    
    func test_loadData_shouldCallDataTaskAsManyTimesAsLoadDataCalled() {
        
        let (httpClientSpy, sut) = makeSUT()
        let requestTimes = 3
        
        for _ in 0..<requestTimes {
            sut.load(urlPath: anyUrl, httpMethod: .get, parameters: nil, headers: nil) { (mockedDTO: MockedDTO) in
            } failure: { (failureModel: NetworkFailure<MockedNetworkFailureModel>) in}
        }

        trackForMemoryLeaks(httpClientSpy)
        trackForMemoryLeaks(sut)

        XCTAssertEqual(requestTimes, httpClientSpy.requestCallsNumber)
    }

    func test_loadData_shoudFailure_inCaseErrorRetrieved() {
        let exp = expectation(description: "Expecting to fulfill failure")
        let (httpClientSpy, sut) = makeSUT()
        httpClientSpy.result = .failure(NSError(domain: "domain", code: 1))
        
        sut.load(urlPath: anyUrl, httpMethod: .get, parameters: nil, headers: nil) { (mocked: MockedDTO) in
            
        } failure: { (mockedFailure: NetworkFailure<MockedNetworkFailureModel>) in
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }
    
    // Failure Status Codes greater than 299 and less than 299
    func test_loadData_shouldFailure_inCaseErrorStatusCode() {
        let exp = expectation(description: #function)
        let (httpClientSpy, sut) = makeSUT()
        let failureCodes = [199, 300]
        exp.expectedFulfillmentCount = failureCodes.count
        for failureCode in failureCodes {
            httpClientSpy.result = .success((getValidJsonData()!, HTTPURLResponse(url: URL(string: anyUrl)!, statusCode: failureCode, httpVersion: nil, headerFields: nil)))
            
            sut.load(urlPath: anyUrl, httpMethod: .get, parameters: nil, headers: nil) { (mocked: MockedDTO) in
            } failure: { (mockedFailure: NetworkFailure<MockedNetworkFailureModel>) in
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }

     // Success Status Codes between 200 and 299
    func test_loadData_shouldSuccess_inCaseSuccessStatusCode() {
        let exp = expectation(description: #function)
        let (httpClientSpy, sut) = makeSUT()
        let httpResponse = HTTPURLResponse(url: URL(string: anyUrl)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        httpClientSpy.result = .success((getValidJsonData()!,httpResponse))
        sut.load(urlPath: anyUrl, httpMethod: .get, parameters: nil, headers: nil) { (mocked: MockedDTO) in
            exp.fulfill()
        } failure: { (failureModel: NetworkFailure<MockedNetworkFailureModel>) in
            XCTFail()
        }
        
        wait(for: [exp], timeout: 1)
    }

    func test_loadData_shouldFail_inCaseFailedToMapRetrievedData() {
        let exp = expectation(description: #function)
        let (httpClientSpy, sut) = makeSUT()
        httpClientSpy.result = .success((getInvalidData() , successResponse))

        sut.load(urlPath: anyUrl, httpMethod: .get, parameters: nil, headers: nil) { (mocked: MockedDTO) in
        } failure: { (mocked: NetworkFailure<MockedNetworkFailureModel>) in
            exp.fulfill()
        }

        
        wait(for: [exp], timeout: 1)
    }
//
    func test_LoadDataDecoding_shouldSuccessForCorrectJsonAndDecodableObject() {
        let exp = expectation(description: #function)
        let (httpClientSpy, sut) = makeSUT()
        httpClientSpy.result = .success((FakeJSON.getData(stubbedJson: .general, bundleObject: self), successResponse))
        
        
        sut.load(urlPath: anyUrl,
                 httpMethod: .get,
                 parameters: nil,
                 headers: nil) { (successModel: RootModel<GeneralTestingJsonRoot>) in
            XCTAssertEqual(successModel.data.root[0].id, 1)
            XCTAssertEqual(successModel.data.root[0].title, "Chicken Run: Dawn of the Nugget")
            XCTAssertEqual(successModel.data.root[0].subTitle, "A band of fearless chickens flock together to save poultry-kind from an unsettling new threat: a nearby farm that cooking up something suspicious.")
            XCTAssertEqual(successModel.data.root[0].url, "https://api.themoviedb.org/3/movie/")
            exp.fulfill()
        } failure: { (failureMode: NetworkFailure<MockedNetworkFailureModel>) in
            
        }

        wait(for: [exp], timeout: 1)
    }

    func makeSUT() -> (HttpClientSpy, NetworkManager) {
        let httpClientSpy = HttpClientSpy()
        let networkManager = NetworkManager(httpClient: httpClientSpy, baseUrl: anyUrl)
        
        return (httpClientSpy, networkManager)
    }
}

class HttpClientSpy: HTTPClient {
    var url: String!
    var httpMethod: HTTPMethod!
    var parameters: [String: Any]!
    var headers: [String: String]!
    
    var requestCallsNumber = 0
    var result: (Result<(Data?, URLResponse?), Error>?)
    
    func request(urlPath: String, httpMethod: TheMovieDB.HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, result: @escaping (Result<(Data?, URLResponse?), Error>) -> ()) {
        requestCallsNumber += 1
        self.url = urlPath
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.headers = headers
    
        if let unwrappedResult = self.result {
            result(unwrappedResult)
        }
    }
}

/// What Network Manager should do?
/* Network manager should use HTTPClient to request remote APIs.
 
 NetworkManager Data needed:-
 - load Method need url, restMethod, Parameters
 
 -> Use Cases:
 1- Should fire failure in case error status code (above 299 or below 200) // done
 2- Should fire failure in case Decodable error // done
 3- Success in case decodable success and resopnse status code 200-299 // done
 4- Sake sure the (parameters, restMethods, URL, headers) passsed to session correctly // done
 5- Should trigger failure in case URLSession triggered Error // done
 
 -> What about the data validation>
 -> Url should be passed correctly from network to urlSession // done
 -> Make sure that one loadData call dataTask one time // done
 */
