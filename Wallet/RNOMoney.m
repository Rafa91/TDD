//
//  RNOMoney.m
//  Wallet
//
//  Created by Rafael Navarro on 4/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import "RNOMoney.h"
#import "NSObject+GNUStepAddons.h"
#import "RNOBroker.h"


@interface RNOMoney ()

@property (nonatomic, strong) NSNumber *amount;

@end

@implementation RNOMoney

+(id)euroWithAmount:(NSInteger)amount{
    return [[RNOMoney alloc]initWithAmount:amount currency:@"EUR"];
}

+(id)dollarWithAmount:(NSInteger)amount{
    return [[RNOMoney alloc]initWithAmount:amount currency:@"USD"];
}

-(id)initWithAmount:(NSInteger)amount
           currency:(NSString *)currency{
    if (self=[super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    
    return self;
    
}

-(id<RNOMoney>)times:(NSInteger)multiplier{
    
    RNOMoney *newMoney = [[RNOMoney alloc] initWithAmount:[self.amount integerValue]*multiplier
                                                 currency:self.currency];
    
    return newMoney;
    
}

-(NSString *) description{
    
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, [self amount]];
    
}

-(BOOL) isEqual:(id)object{
    
    if ([self.currency isEqual:[object currency]]) {
        return  [self amount]   ==  [object amount];
    }else{
        return NO;
    }
    
}
-(NSUInteger)hash{
    return [self.amount integerValue];
}

-(id<RNOMoney>)plus:(RNOMoney *)other{
    
    NSInteger totalAmount = [self.amount integerValue]+ [other.amount integerValue];
    
    RNOMoney *total = [[RNOMoney alloc] initWithAmount:totalAmount
                                              currency:self.currency];
    
    return total;
    
}

-(id<RNOMoney>)reduceToCurrency:(NSString *)currency withBroker:(RNOBroker *)broker{
    
    RNOMoney *result;
    double rate= [[broker.rates objectForKey:[broker keyFromCurrency:self.currency toCurrency:currency]] doubleValue];
    
    //Comprobamos que divisa de origen y de destino son las mismas
    if ([self.currency isEqual:currency]) {
        result = self;
    }else if(rate == 0){
        //lanzamos excepción porque no hay tasa de conversión
        [NSException raise:@"NoConversionRateException" format:@"Must have a conversion from %@ to %@", self.currency, currency];
    }else{
        double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency
                                                           toCurrency:currency]] doubleValue];
        
        NSInteger newAmount = [self.amount integerValue] * rate;
        
        result = [[RNOMoney alloc] initWithAmount:newAmount
                                         currency:currency];
    }
    
    
    
    return result;

    
}

@end
