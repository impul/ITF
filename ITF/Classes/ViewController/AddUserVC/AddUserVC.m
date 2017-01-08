//
//  AddUserVC.m
//  ITF
//
//  Created by Impulse on 08.01.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

#import "SelectItemFromArrayViewController.h"
#import "AddUserVC.h"
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface AddUserVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *facultyTextField;
@property (weak, nonatomic) IBOutlet UITextField *coursTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *addUserButton;
@property (strong, nonatomic) NSArray *arrayOfITF;

@end

@implementation AddUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursTextField.enabled = NO;
    self.userNameTextField.enabled = NO;
    self.addUserButton.enabled = NO;
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addUserAction:(id)sender {
    FIRDatabaseReference *fir = [[FIRDatabase database] reference];
    [[[[[[fir child:@"ITF"] child:self.facultyTextField.text] child:@"Courses"] child:self.coursTextField.text]childByAutoId] setValue:@{@"Name":self.userNameTextField.text} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.facultyTextField]) {
        SelectItemFromArrayViewController *selectItem = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectItemFromArrayViewController"];
        [selectItem setupControllerWithItemsArray:[self.dictOfITF allKeys] andTextField:self.facultyTextField];
        selectItem.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:selectItem animated:YES completion:nil];
        return NO;
    }
    if ([textField isEqual:self.coursTextField]) {
        SelectItemFromArrayViewController *selectItem = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectItemFromArrayViewController"];
        [selectItem setupControllerWithItemsArray:@[@"1 course",@"2 course",@"3 course",@"4 course",@"5 course"] andTextField:self.coursTextField];
        selectItem.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:selectItem animated:YES completion:nil];
        return NO;
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.facultyTextField.text.length) {
        self.coursTextField.enabled = YES;
    }
    if (self.coursTextField.text.length) {
        self.userNameTextField.enabled = YES;
    }
    if (self.userNameTextField.text.length) {
        self.addUserButton.enabled = YES;
    }
    
    return YES;
}


@end
