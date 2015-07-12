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

-(void) testSubstraction{
    
    RNOWallet *wallet = [[RNOWallet alloc] initWithAmount:20 currency:@"EUR"];
    
    [wallet takeMoney:[RNOMoney euroWithAmount:20]];
    
    NSUInteger total = [wallet count];
    
    XCTAssertEqual(total, 0, @"20€ - 20€ = 0€");
    
    
}

-(void) testThatSubstractionOfANonExistingMoneyThrowException{
    
    RNOWallet *wallet = [[RNOWallet alloc] initWithAmount:20 currency:@"EUR"];
    
    
    XCTAssertThrows([wallet takeMoney:[RNOMoney euroWithAmount:10]], @"Substraction of a non existing money throw exception");
    
}

-(void) testCountOfCurrencies{
    RNOWallet *wallet = [[RNOWallet alloc] initWithAmount:10 currency:@"EUR"];
    
    [wallet addMoney:[RNOMoney dollarWithAmount:10]];
    
    XCTAssertEqual([wallet countCurrencies], 2, @"The number of currencies in the wallet should be two");
    
}


-(void) testTotalMoneysOfOneCurrency{
    
    RNOWallet *wallet = [[RNOWallet alloc] initWithAmount:20 currency:@"EUR"];
    
    [wallet addMoney:[RNOMoney euroWithAmount:10]];
    [wallet addMoney:[RNOMoney euroWithAmount:30]];
    [wallet addMoney:[RNOMoney dollarWithAmount:10]];
    
    NSUInteger rows = [wallet countForCurrency:@"EUR"];
    
    XCTAssertEqual(rows, 3, @"Wallet should contain 3 objects for currency EUR");
    
}

-(void) testMoneyAtIndexForCurrency{
    
    RNOWallet *wallet = [[RNOWallet alloc] initWithAmount:20 currency:@"EUR"];
    
    [wallet addMoney:[RNOMoney euroWithAmount:10]];
    [wallet addMoney:[RNOMoney euroWithAmount:30]];
    [wallet addMoney:[RNOMoney dollarWithAmount:10]];

    RNOMoney *m = [wallet moneyAtIndex:1 forCurrency: @"EUR"];
    
    XCTAssertEqualObjects(m, [RNOMoney euroWithAmount:10], @"Both objects should be equals");
    
}

-(void) testSimpleTotalMoneyForCurrency{
    
    RNOWallet *wallet = [[RNOWallet alloc] initWithAmount:20 currency:@"EUR"];
    
    [wallet addMoney:[RNOMoney dollarWithAmount:10]];
    [wallet addMoney:[RNOMoney dollarWithAmount:10]];
    [wallet addMoney:[RNOMoney euroWithAmount:10]];
    
    RNOMoney *totalEuros = [wallet reduceForCurrency: @"EUR"];
    
    RNOMoney *totalEurostest = [RNOMoney euroWithAmount:30];
    
    XCTAssertEqualObjects(totalEuros, totalEurostest, @"Should be equal if 30€=30€");
    
}

@end
