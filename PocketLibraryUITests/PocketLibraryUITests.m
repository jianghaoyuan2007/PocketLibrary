//
//  PocketLibraryUITests.m
//  PocketLibraryUITests
//
//  Created by Stephen Chiang on 2018/4/19.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PocketLibraryUITests-Swift.h"

@class Snapshot;
@interface PocketLibraryUITests : XCTestCase

@end

@implementation PocketLibraryUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    [Snapshot setupSnapshot:app];
    
    [app launch];
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testScreenshot {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [Snapshot snapshot:@"01-Library" timeWaitingForIdle:1];
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.navigationBars[@"Library"].buttons[@"Import"] tap];
    [Snapshot snapshot:@"02-Import Resources" timeWaitingForIdle:1];
    
    [app.navigationBars[@"Import Resources"].buttons[@"Close"] tap];
    [[app.cells elementBoundByIndex: 0] tap];
    [Snapshot snapshot:@"03-Chapters" timeWaitingForIdle:1];

    [[app.cells elementBoundByIndex: 0] tap];
    [Snapshot snapshot:@"04-Units" timeWaitingForIdle:1];

    [[app.cells elementBoundByIndex: 0] tap];
    [Snapshot snapshot:@"05-Media Player" timeWaitingForIdle:1];
}

@end
