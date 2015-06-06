//
//  RNOWallet.m
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import "RNOWallet.h"

@interface RNOWallet ()

@property (nonatomic, strong) NSMutableArray *moneys;

@end

@implementation RNOWallet

-(NSUInteger) count{
    return [self.moneys count];
}

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency{
    
    if (self = [super init]) {
        RNOMoney *money = [[RNOMoney alloc] initWithAmount:amount
                                                  currency:currency];
        
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
        
    }
    
    return self;
    
}

-(id<RNOMoney>)times:(NSInteger)multiplier{
    
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];
    
    for (RNOMoney *each in self.moneys) {
        RNOMoney *newMoney = [each times:multiplier];
        [newMoneys addObject:newMoney];
    }
    
    self.moneys = newMoneys;
    return self;
    
}

-(id<RNOMoney>)plus:(RNOMoney *)other{
    
    [self.moneys addObject:other];
    return self;
    
}

-(id<RNOMoney>)reduceToCurrency:(NSString *)currency withBroker:(RNOBroker *)broker{
    
    RNOMoney *result = [[RNOMoney alloc] initWithAmount:0 currency:currency];
    for (RNOMoney *each in self.moneys) {
        result = [result plus:[each reduceToCurrency:currency withBroker:broker]];
    }
    
    return result;
}

@end
