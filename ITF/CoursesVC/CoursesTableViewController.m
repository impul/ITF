//
//  CoursesTableViewController.m
//  ITF
//
//  Created by Pavlo Boiko on 18.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "CoursesTableViewController.h"

@interface CoursesTableViewController ()

@property (strong ,nonatomic) NSDictionary *courses;

@end

@implementation CoursesTableViewController

#pragma mark - LifeCicle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseCell" forIndexPath:indexPath];
    
    cell.textLabel.text  = [[self.courses allValues] objectA
    return cell;
}

#pragma mark - SetupController

-(void)setupControllerWithCourses:(NSDictionary *)course {
    self.courses = [course valueForKey:@"Course"];
    [self.tableView reloadData];
}






@end
