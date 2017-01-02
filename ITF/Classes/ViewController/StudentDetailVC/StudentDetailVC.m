//
//  StudentDetailVC.m
//  ITF
//
//  Created by Pavlo Boiko on 20.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "StudentDetailVC.h"

@interface StudentDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *studentNameLable;
@property (strong,nonatomic) NSDictionary *modulesDict;
@property (strong,nonatomic) NSString *studentName;
@end

@implementation StudentDetailVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.studentNameLable.text = self.studentName;
}

-(void)setupControllerWithDict:(NSDictionary *)dict {
    self.navigationItem.title = [dict valueForKey:@""];
    [self.navigationController.navigationBar pushNavigationItem:self.navigationItem animated:NO];
    self.studentName = [dict valueForKey:@"Name"];
    self.modulesDict = [dict valueForKey:@"Modules"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modulesDict.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"muduleCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.modulesDict allKeys] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[self.modulesDict allValues]objectAtIndex:indexPath.row];
    
    return cell;
}


@end
