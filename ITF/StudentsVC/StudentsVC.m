//
//  StudentsVC.m
//  ITF
//
//  Created by Pavlo Boiko on 19.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "StudentsVC.h"
#import "StudentDetailVC.h"

@interface StudentsVC ()
@property (strong ,nonatomic) NSDictionary *studentDict;
@end

@implementation StudentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setupControllerWithDict:(NSDictionary *)dict andIndex:(NSInteger)index {
    self.navigationItem.title = [NSString stringWithFormat:@"%lu course",index+1];
    [self.navigationController.navigationBar pushNavigationItem:self.navigationItem animated:NO];
    self.studentDict = dict;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    cell.textLabel.text = [[[self.studentDict allValues] objectAtIndex:indexPath.row] valueForKey:@"Name"];
    cell.detailTextLabel.text = [self getCenterRankAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentDetailVC *sVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentDetailVC"];
    [sVC setupControllerWithDict:[[self.studentDict allValues] objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:sVC animated:YES];
}

#pragma mark - Private
-(NSString *)getCenterRankAtIndex:(NSInteger)index {
    NSArray *ranks = [[[[self.studentDict allValues] objectAtIndex:index] valueForKey:@"Modules"] allValues];
    float studRank = 0;
    for (NSString *str in ranks) {
        studRank +=[str integerValue];
    }
    studRank = studRank/ranks.count;
    return [NSString stringWithFormat:@"%.2f",studRank];
}
@end
