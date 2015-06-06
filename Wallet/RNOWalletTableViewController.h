//
//  RNOWalletTableViewController.h
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNOWallet;
@interface RNOWalletTableViewController : UITableViewController

-(id) initWithModel:(RNOWallet *) model;

@end
