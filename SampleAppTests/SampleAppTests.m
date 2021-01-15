//
//  SampleAppTests.m
//  SampleAppTests
//
//  Created by Dimitris Koutsogiorgas on 12/16/19.
//  Copyright © 2019 Dimitris Koutsogiorgas. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Framework55;

@interface SampleAppTests : XCTestCase

@end

@implementation SampleAppTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertTrue(true);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
