//
//  RNOControllerTests.m
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RNOSimpleViewController.h"
#import "RNOWalletTableViewController.h"
#import "RNOWallet.h"

@interface RNOControllerTests : XCTestCase
@property (nonatomic,strong) RNOSimpleViewController *simpleVC;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) RNOWalletTableViewController *walletVC;
@property (nonatomic, strong) RNOWallet *wallet;
@end

@implementation RNOControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.simpleVC = [[RNOSimpleViewController alloc] initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola!" forState:UIControlStateNormal];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;
    self.wallet = [[RNOWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[RNOMoney euroWithAmount:1]];
    self.walletVC = [[RNOWalletTableViewController alloc] initWithModel:self.wallet];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
}

-(void) testThatTextOnLabelIsEqualToTextOnButton{
    
    //mandamos el mensaje
    [self.simpleVC displayText:self.button];
    
    //comprobamos que etiqueta y boton tienen el mismo texto
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text, @"Button and label should have the same text");
}

-(void) testThatTableHasOneSection{
    
    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    XCTAssertEqual(sections, 1, @"There can only be one!");
    
}

-(void) testThatNumberOfCellsIsNumberOfMoneyPlusOne{
    
    XCTAssertEqual(self.wallet.count + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Number of cells is the number of moneys plus 1: (the total)");
    
}

@end
