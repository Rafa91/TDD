//
//  RNOSimpleViewController.h
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNOSimpleViewController : UIViewController

- (IBAction)displayText:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@end
