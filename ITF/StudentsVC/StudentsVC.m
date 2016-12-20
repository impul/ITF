//
//  StudentsVC.m
//  ITF
//
//  Created by Pavlo Boiko on 19.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "StudentsVC.h"

@interface StudentsVC ()

@end

@implementation StudentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    cell.textLabel.text = [[[self.studentDict allValues] objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    return cell;
}

@end
