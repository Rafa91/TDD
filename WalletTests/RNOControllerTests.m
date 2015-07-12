//
//  RNOControllerTests.m
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RNOWalletTableViewController.h"
#import "RNOWallet.h"
#import "RNOBroker.h"

@interface RNOControllerTests : XCTestCase
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) RNOWalletTableViewController *walletVC;
@property (nonatomic, strong) RNOWallet *wallet;
@property (nonatomic, strong) RNOBroker *broker;
@end

@implementation RNOControllerTests

- (void)setUp {
    [super setUp];
    
    self.broker =[[RNOBroker alloc] init];
    [self.broker addRate:2
            fromCurrency:@"EUR"
              toCurrency:@"USD"];
    
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.wallet = [[RNOWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[RNOMoney euroWithAmount:1]];
    self.walletVC = [[RNOWalletTableViewController alloc] initWithModel:self.wallet];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



-(void) testThatNumberOfCellsForCurrencyIsNumberOfMoneyPlusOne{
    
    
    XCTAssertEqual([self.wallet countForCurrency:[self.wallet.currenciesList objectAtIndex:0]] + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Number of cells is the number of moneys plus 1: (the total)");
    
}

-(void) testThatNumberOfSectionIsNumberOfCurrenciesInWalletPlusOne{
    
    XCTAssertEqual([self.wallet countCurrencies]+1, [self.walletVC numberOfSectionsInTableView:nil], @"Number of sections isthe number of currencies plus 1");
    
}



@end
