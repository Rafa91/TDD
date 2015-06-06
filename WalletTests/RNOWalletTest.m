//
//  RNOWalletTest.m
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RNOMoney.h"
#import "RNOBroker.h"
#import "RNOWallet.h"

@interface RNOWalletTest : XCTestCase

@end

@implementation RNOWalletTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testAdditionWithReduction{
    
    RNOBroker *broker = [RNOBroker new];
    [broker addRate:2
       fromCurrency:@"EUR"
         toCurrency:@"USD"];
    
    RNOWallet *wallet = [[RNOWallet alloc] initWithAmount:40 currency:@"EUR"];
    [wallet plus: [RNOMoney dollarWithAmount:20]];
    
    RNOMoney *reduced = [broker reduce:wallet toCurrency:@"USD"];
    
    XCTAssertEqualObjects(reduced, [RNOMoney dollarWithAmount:100], @"€40 + $20 = $100 2:1");
    
}

@end
