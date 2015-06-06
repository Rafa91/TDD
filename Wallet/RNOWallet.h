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

@end
