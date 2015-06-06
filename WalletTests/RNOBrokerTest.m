//
//  RNOBrokerTest.m
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RNOMoney.h"
#import "RNOBroker.h"

@interface RNOBrokerTest : XCTestCase

@property (nonatomic, strong) RNOBroker *emptyBroker;
@property (nonatomic, strong) RNOMoney *oneDollar;

@end

@implementation RNOBrokerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.emptyBroker = [RNOBroker new];
    self.oneDollar = [RNOMoney dollarWithAmount:1];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.emptyBroker = nil;
    self.oneDollar = nil;
}

-(void) testSimpleReduction{
    
    RNOMoney *sum = [[RNOMoney dollarWithAmount:5] plus:[RNOMoney dollarWithAmount:5]];
    
    RNOMoney * reduced = [self.emptyBroker reduce:sum toCurrency: @"USD"];
    
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
    
}

-(void) testReduction{
    
    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    RNOMoney *dollars = [RNOMoney dollarWithAmount:10];
    RNOMoney *euros = [RNOMoney euroWithAmount:5];
    
    RNOMoney *converted = [self.emptyBroker reduce:dollars toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 == €5 2:1");
    
}

-(void) testThatNoRateRaisesException{
    
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"], @"No rates should cause exception");
    
}

-(void) testThatNilConversionDoesNotChangeMoney{
    
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar toCurrency:@"USD"],@"A nil conversion should have no effect");
    
}

@end
