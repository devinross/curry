//
//  RootTableViewController.m
//  Examples
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "RootTableViewController.h"
#import "CreditCardEntryViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController

#define IDENTIFIER @"cellIdentifier"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    
    
    cell.textLabel.text = @"Credit Card Text Fields";
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.navigationController pushViewController:CreditCardEntryViewController.new animated:YES];
    
}






@end
