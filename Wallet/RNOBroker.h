//
//  RNOBroker.h
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNOMoney.h"

@interface RNOBroker : NSObject

@property (nonatomic, strong) NSMutableDictionary *rates;

-(RNOMoney *) reduce:(id<RNOMoney>) money toCurrency:(NSString *) currency;

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString *) fromCurrency
     toCurrency:(NSString *) toCurrency;
-(NSString *) keyFromCurrency:(NSString *)fromCurrency
                   toCurrency:(NSString *)toCurrency;

@end
