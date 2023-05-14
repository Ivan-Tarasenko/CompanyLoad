//
//  CompanyLoadTests.swift
//  CompanyLoadTests
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import XCTest
@testable import CompanyLoad

final class CompanyLoadTests: XCTestCase {
    
    var expectation: XCTestExpectation?
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testOfObtainingDataInIdealConditions() throws {
        
        let expectation = expectation(description: "api.ideal")
        
        let url =  "http://dev.bonusmoney.pro/mobileapp/getAllCompaniesIdeal"
        
        let parameter = generateParameter(url: url)
        
        let task = URLSession.shared.dataTask(with: parameter) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            
            if let httpResponse = response as? HTTPURLResponse {
                XCTAssertEqual(httpResponse.statusCode, 200)
            }
            
            expectation.fulfill()
            
        }
        
        task.resume()
        
        waitForExpectations(timeout: task.originalRequest?.timeoutInterval ?? 10) {error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
    func testErrorReceiving() throws {
        let expectation = expectation(description: "api.error")
        
        let url =  "http://dev.bonusmoney.pro/mobileapp/getAllCompaniesError"
        
        let parameter = generateParameter(url: url)

        let task = URLSession.shared.dataTask(with: parameter) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 400:
                    XCTAssertEqual(httpResponse.statusCode, 400)
                    let massage = self.getMassage(withData: data)
                    XCTAssertNotNil(massage)
                case 401:
                    print(httpResponse.statusCode)
                    XCTAssertEqual(httpResponse.statusCode, 401)
                case 500:
                    print(httpResponse.statusCode)
                    XCTAssertEqual(httpResponse.statusCode, 500)
                default:
                    break
                }
            }
            
            expectation.fulfill()
            
        }
        
        task.resume()
        
        waitForExpectations(timeout: task.originalRequest?.timeoutInterval ?? 10) {error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func generateParameter(url: String) -> URLRequest {
        let parameters = "{\n\t\"offset\": 0\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: url)!,
                                 timeoutInterval: Double.infinity)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        return request
    }
    
    private func getMassage(withData data: Data? ) -> String? {
        if let responseData = data,
           let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: []),
           let errorDict = jsonResponse as? [String: Any],
           let errorMessage = errorDict["message"] as? String {
            return errorMessage
        }
        return nil
    }
    
}
