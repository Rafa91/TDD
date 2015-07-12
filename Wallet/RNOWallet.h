//
//  RNOWallet.h
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNOMoney.h"

@interface RNOWallet : NSObject <RNOMoney>

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) NSUInteger countCurrencies;
@property (nonatomic, readonly) NSArray *currenciesList;

-(id<RNOMoney>) addMoney: (RNOMoney *) money;
-(id<RNOMoney>) takeMoney: (RNOMoney *) money;

-(NSUInteger) countForCurrency:(NSString *)currency;
-(RNOMoney *) moneyAtIndex:(NSInteger) index
               forCurrency:(NSString *)currency;

-(RNOMoney *) reduceForCurrency:(NSString *) currency;

@end
