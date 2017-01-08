//
//  MailLoginVC.m
//  ITF
//
//  Created by Impulse on 06.01.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

#import "MailLoginVC.h"
@import FirebaseAuth;

@interface MailLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation MailLoginVC

#pragma mark - LifeCicle

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view.
}

- (BOOL) shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return (UIInterfaceOrientationPortrait |  UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)loginAction:(id)sender {
    if ([self checkFieldsValidation]) {
        [[FIRAuth auth] signInWithEmail:self.mailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            [self manageUser:user error:error];
        }];
    }
}

- (IBAction)registerAction:(id)sender {
    if ([self checkFieldsValidation]) {
        [[FIRAuth auth] createUserWithEmail:self.mailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            [self manageUser:user error:error];
        }];
    }
}

-(void)manageUser:(FIRUser * _Nullable)user error:(NSError * _Nullable)error {
    if (!error) {
        UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        [self presentViewController:navigation animated:YES completion:nil];
    } else {
        [self showAlertWithError:error];
    }
}

-(BOOL)checkFieldsValidation {
    if (!self.mailTextField.text.length || self.passwordTextField.text.length < 6) {
        [self showAlertWithError:nil];
        return NO;
    }
    return YES;
}

-(void)showAlertWithError:(NSError * _Nullable)error {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"Sorry" message:error ? error.localizedDescription : @"Fill correct infrmation" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [aler addAction:action];
    [self presentViewController:aler animated:YES completion:nil];
}

@end
