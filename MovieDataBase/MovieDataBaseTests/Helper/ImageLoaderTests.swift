//
//  ImageLoaderTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
@testable import MovieDataBase

class ImageLoaderTests: XCTestCase {

    var imageView: UIImageView!
    var imageLoader: ImageLoader!

    override func setUp() {
        super.setUp()
        imageView = UIImageView()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        imageLoader = ImageLoader(session: session)
    }

    override func tearDown() {
        imageView = nil
        imageLoader = nil
        MockURLProtocol.requestHandler = nil
        URLCache.shared.removeAllCachedResponses() // Clear the cache
        super.tearDown()
    }

    func testLoadImage_withValidURL_shouldLoadImageSuccessfully() {
        let imageData = UIImage(systemName: "star.fill")?.pngData()
        let url = URL(string: "https://example.com/image.png")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        mockURLSession(with: imageData, response: response, error: nil)

        let expectation = self.expectation(description: "Image load expectation")
        imageLoader.loadImage(from: url.absoluteString, into: imageView)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertNotNil(self.imageView.image)
    }

    func testLoadImage_withInvalidURL_shouldSetPlaceholderImage() {
        // Given
        let invalidURLString = "invalid_url"
        let error = NSError(domain: "Invalid URL", code: -1, userInfo: nil)

        // Mocking the session to simulate an error due to invalid URL
        mockURLSession(with: nil, response: nil, error: error)

        // When
        let expectation = self.expectation(description: "Image load expectation")

        imageLoader.loadImage(from: invalidURLString, into: imageView)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        // Then
        XCTAssertEqual(imageView.image, UIImage(named: "folderThumbnail"))
    }

    func testLoadImage_withNetworkError_shouldSetPlaceholderImage() {
        let url = URL(string: "https://example.com/image.png")!
        let error = NSError(domain: "NetworkError", code: -1, userInfo: nil)

        mockURLSession(with: nil, response: nil, error: error)

        let expectation = self.expectation(description: "Image load expectation")
        imageLoader.loadImage(from: url.absoluteString, into: imageView)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertEqual(imageView.image, UIImage(named: "folderThumbnail"))
    }

    private func mockURLSession(with data: Data?, response: URLResponse?, error: Error?) {
        MockURLProtocol.requestHandler = { request in
            let httpResponse = response as? HTTPURLResponse
            return (httpResponse, data, error)
        }
    }
}

// MARK: - MockURLProtocol

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) -> (HTTPURLResponse?, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Handler is unavailable.")
            return
        }
        
        let (response, data, error) = handler(request)
        
        if let response = response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
