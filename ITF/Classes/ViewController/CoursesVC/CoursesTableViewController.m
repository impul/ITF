//
//  CoursesTableViewController.m
//  ITF
//
//  Created by Pavlo Boiko on 18.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "StudentsVC.h"

@interface CoursesTableViewController ()

@property (strong ,nonatomic) NSMutableArray *courses;

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
    
    cell.textLabel.text  = [NSString stringWithFormat:@"%lu course",indexPath.row+1];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", ((NSDictionary *)self.courses[indexPath.row]).count];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentsVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentsVC"];
    [vc setupControllerWithDict:self.courses[indexPath.row] andIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SetupController

-(void)setupControllerWithCourses:(NSDictionary *)course {
    self.navigationItem.title = [course valueForKey:@"Name"];
    [self.navigationController.navigationBar pushNavigationItem:self.navigationItem animated:NO];
    self.courses = [NSMutableArray new];
    for (id obj in [course valueForKey:@"Courses"]) {
        if (![obj isKindOfClass:[NSNull class]])
        {
            [self.courses addObject:obj];
        }
    }
    [self.tableView reloadData];
}






@end
