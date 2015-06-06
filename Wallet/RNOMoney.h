//
//  RNOMoney.h
//  Wallet
//
//  Created by Rafael Navarro on 4/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RNOMoney;
@class RNOBroker;

@protocol RNOMoney <NSObject>

-(id) initWithAmount:(NSInteger) amount
            currency:(NSString *)currency;

-(id<RNOMoney>) times:(NSInteger) multiplier;

-(id<RNOMoney>) plus: (RNOMoney *) other;

-(id<RNOMoney>) reduceToCurrency:(NSString *)currency withBroker: (RNOBroker *)broker;

@end

@interface RNOMoney : NSObject<RNOMoney>

@property (nonatomic, readonly) NSString *currency;

@property (nonatomic, strong, readonly) NSNumber *amount;

+(id) euroWithAmount:(NSInteger) amount;

+(id) dollarWithAmount:(NSInteger) amount;



@end
