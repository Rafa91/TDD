//
//  RNOBroker.m
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import "RNOBroker.h"
#import "RNOMoney.h"


@implementation RNOBroker

-(id) init{
    
    if (self = [super init]) {
        _rates = [@{}mutableCopy];
    }
    return self;
}

-(RNOMoney *)reduce:(id<RNOMoney>)money
         toCurrency:(NSString *)currency{

    return [money reduceToCurrency:currency
                        withBroker:self];
    
}

-(void)addRate:(NSInteger)rate
  fromCurrency:(NSString *)fromCurrency
    toCurrency:(NSString *)toCurrency{
    
    [self.rates setObject:@(rate) forKey:[self keyFromCurrency:fromCurrency toCurrency:toCurrency]];
    [self.rates setObject:@(1.0/rate) forKey:[self keyFromCurrency:toCurrency toCurrency:fromCurrency]];
    
}

-(NSString *) keyFromCurrency:(NSString *)fromCurrency
                   toCurrency:(NSString *)toCurrency{
    
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
    
}

@end
