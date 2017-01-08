//
//  SelectItemFromArrayViewController.m
//  Shorik
//
//  Created by iMac on 13.10.16.
//  Copyright © 2016 Boost. All rights reserved.
//

#import "SelectItemFromArrayViewController.h"

@interface SelectItemFromArrayViewController () <UIPickerViewDelegate , UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) UITextField *currentTextField;

@property (strong, nonatomic) NSArray *itemsArray;
@property (nonatomic) NSInteger selectedIndex;
@end

@implementation SelectItemFromArrayViewController

#pragma mark - SetupController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
}

-(void)setupControllerWithItemsArray:(NSArray *)array andTextField:(UITextField *)textField
{
    self.currentTextField = textField;
    self.itemsArray = array;
    [self.pickerView reloadAllComponents];
}

#pragma mark - PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.itemsArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedIndex = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
        [label setFont:[UIFont fontWithName:@"GothamPro-Light" size:14]];
        label.text = [self.itemsArray objectAtIndex:row];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:15];    label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        return label;
}

#pragma mark - Actions

- (IBAction)cancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneAction:(id)sender {
    self.currentTextField.text = self.itemsArray[self.selectedIndex];
    [self.currentTextField.delegate textField:self.currentTextField shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@""];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
