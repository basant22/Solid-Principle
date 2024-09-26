//
//  CommentViewModelTest.swift
//  Solid PrincipleTests
//
//  Created by Kumar Basant on 17/07/24.
//

import XCTest
@testable import Solid_Principle
import Combine
class CommentViewModelTest:XCTestCase{
    @MainActor func test_Api_Failure(){
        let mockService = MockCommentViewService()
        mockService.result = .failure(ApiError.InvalidJson)
        var sut = CommentViewModel(dbSevices: mockService)
        XCTAssert(sut.comments.isEmpty)
    }
    @MainActor func test_Api_Success(){
        let mockService = MockCommentViewService()
        guard let comments = mockService.comments() else {return}
        mockService.result = .success(comments)
        var sut = CommentViewModel(dbSevices: mockService)
        let expectation = XCTestExpectation(description: "fetch comments")
        var cancellable:AnyCancellable?
        cancellable = sut.$comments
            .dropFirst()
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
        sut.getComments()
        wait(for: [expectation], timeout: 5.0)
        XCTAssert(!sut.comments.isEmpty)
    }
}
