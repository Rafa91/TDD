//
//  RNOMoneyTest.m
//  Wallet
//
//  Created by Rafael Navarro on 4/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RNOMoney.h"

@interface RNOMoneyTest : XCTestCase

@end

@implementation RNOMoneyTest

-(void) testCurrent{
    
    XCTAssertEqualObjects(@"EUR", [[RNOMoney euroWithAmount:1] currency], @"The currency of euros should be EUR");
    XCTAssertEqualObjects(@"USD", [[RNOMoney dollarWithAmount:1] currency], @"The currency of $1 should be USD");
    
}

-(void) testMultiplication{
    
    RNOMoney *euro = [RNOMoney euroWithAmount:5];
    RNOMoney *ten = [RNOMoney euroWithAmount:10];
    RNOMoney *total  = [euro times:2];
    
    XCTAssertEqualObjects(total, ten, @"should be equal");
    
}

-(void)testEquality{
    
    RNOMoney *five = [RNOMoney euroWithAmount:5];
    RNOMoney *ten = [RNOMoney euroWithAmount:10];
    RNOMoney *total = [five times:2];
    XCTAssertEqualObjects(ten, total, @"Equivalent objects should be equal!");
    RNOMoney *fived = [RNOMoney dollarWithAmount:5];
    RNOMoney *tend = [RNOMoney dollarWithAmount:10];
    RNOMoney *totald = [fived times:2];
    XCTAssertEqualObjects(tend, totald, @"Equivalent objects should be equal!");
    
}

-(void) testDifferentCurrencies{
    
    RNOMoney *euro = [RNOMoney euroWithAmount:1];
    RNOMoney *dollar = [RNOMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different curriecies should not be equal");
}

-(void) testHash{
    
    RNOMoney *five = [RNOMoney euroWithAmount:5];
    RNOMoney *ten = [RNOMoney euroWithAmount:10];
    RNOMoney *total = [five times:2];
    
    XCTAssertEqual([total hash], [ten hash], @"Equal objects must have the same hash");
    
}

-(void) testHashStorage{
    
    RNOMoney *one = [RNOMoney dollarWithAmount:1];
    XCTAssertEqual([one hash], 1, @"The has must be the same as the amount");
    
}

-(void) testAmountStorage{
    RNOMoney *euro = [RNOMoney euroWithAmount:2];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)]integerValue], @"The value retrieved should be the same as the storage");
    
#pragma clang diagnostic pop
}

-(void) testSimpleAddition{
    
    XCTAssertEqualObjects([[RNOMoney dollarWithAmount:5] plus: [RNOMoney dollarWithAmount:5]], [RNOMoney dollarWithAmount:10], @"$5+$5 = $10");
    
}

-(void) testDescription{
    
    RNOMoney *one = [RNOMoney dollarWithAmount:1];
    NSString *desc = @"<RNOMoney: USD 1>";
    
    XCTAssertEqualObjects(desc, [one description], @"Description must match template");
    
}

@end
