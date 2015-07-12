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
@property (nonatomic, strong) NSMutableArray *currencies;

@end

@implementation RNOWallet

-(NSUInteger) count{
    return [self.moneys count];
}

-(NSUInteger) countCurrencies{
    return [self.currencies count];
}

-(NSArray *)currenciesList{
    return [NSArray arrayWithArray:self.currencies ];
}

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency{
    
    if (self = [super init]) {
        RNOMoney *money = [[RNOMoney alloc] initWithAmount:amount
                                                  currency:currency];
        
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
        
        _currencies = [NSMutableArray array];
        [_currencies addObject:currency];
        
        
        
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

-(id<RNOMoney>)addMoney:(RNOMoney *)money{
    [self.moneys addObject:money];
    if (![self.currencies containsObject:money.currency]) {
        [self.currencies addObject:money.currency];
    }
    
    return self;
}

-(id<RNOMoney>)takeMoney:(RNOMoney *)money{
    if (![self.moneys containsObject:money]) {
        [NSException raise:@"TryingToSubstractANonExistingMoneyException"
                    format:@"Imposible to substract %@ %@ from the wallet", money.amount, money.currency];
    }
    [self.moneys removeObject:money];
    return self;
}

-(NSUInteger) countForCurrency:(NSString *)currency{
    
    return [[self moneysForCurrency:currency] count];
    
}

-(NSArray *)moneysForCurrency:(NSString *) currency{
    
    NSMutableArray *mc = [NSMutableArray array];
    
    for (RNOMoney *each in self.moneys) {
        if ([each.currency isEqualToString:currency]) {
            [mc addObject:each];
        }
    }
    
    return mc;
    
}

-(RNOMoney *)moneyAtIndex:(NSInteger)index forCurrency:(NSString *)currency{
    
    return [[self moneysForCurrency:currency] objectAtIndex:index];
    
}

-(RNOMoney *)reduceForCurrency:(NSString *)currency{
    
    RNOMoney *total = [[RNOMoney alloc] initWithAmount:0
                                              currency:currency];
    
    for (RNOMoney *each in self.moneys) {
        if ([each.currency isEqualToString:currency]) {
            total = [total plus:each];
        }
    }
    
    return total;
    
}

@end
