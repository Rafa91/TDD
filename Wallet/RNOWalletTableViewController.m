//
//  RNOWalletTableViewController.m
//  Wallet
//
//  Created by Rafael Navarro on 6/6/15.
//  Copyright (c) 2015 Rafa. All rights reserved.
//

#import "RNOWalletTableViewController.h"
#import "RNOWallet.h"
#import "RNOBroker.h"

@interface RNOWalletTableViewController ()

@property (nonatomic, strong) RNOWallet *model;
@property (nonatomic, strong) RNOBroker *broker;

@end

@implementation RNOWalletTableViewController

-(id)initWithModel:(RNOWallet *)model{
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _model = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.broker addRate:2
            fromCurrency:@"EUR"
              toCurrency:@"USD"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.model countCurrencies]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([self.model countCurrencies]== section) {
        return 1;
    }
    return [self.model countForCurrency:[self.model.currenciesList objectAtIndex:section]]+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId= @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellId];
    };
    RNOMoney *m;
    if (indexPath.section == self.model.countCurrencies) {
        m = [self.broker reduce:self.model toCurrency:@"EUR"];
    }else{
        if ([self.model countForCurrency:[self.model.currenciesList objectAtIndex:indexPath.section]] == indexPath.row) {
            m = [self.model reduceForCurrency:[self.model.currenciesList objectAtIndex:indexPath.section]];
        }else{
            m = [self.model moneyAtIndex:indexPath.row
                                       forCurrency:[self.model.currenciesList objectAtIndex:indexPath.section]];
        }
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", m];
    
    return cell;
    
}

@end
