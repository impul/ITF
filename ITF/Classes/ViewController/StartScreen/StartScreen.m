//
//  StartScreen.m
//  ITF
//
//  Created by Impulse on 21.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "StartScreen.h"
#import "FacultyVC.h"


@implementation StartScreen

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.8 animations:^{
        self.aboutX.constant = 100;
        self.loginX.constant = -100;
         [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self senButtonYPosition];
    }];
}

-(void)senButtonYPosition {
    [UIView animateWithDuration:1 animations:^{
        self.aboutX.constant = 0;
        self.loginX.constant = 0;
        self.aboutY.constant = 150;
        self.loginY.constant = -150;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)skipAction:(id)sender {
    [UIView animateWithDuration:1 animations:^{
        self.aboutY.constant = 0;
        self.loginY.constant = 0;
         [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        [self presentViewController:navigation animated:YES completion:nil];
    }];
}

- (IBAction)aboutAction:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
    NSInteger pos = self.view.frame.size.width/2+50;
    [UIView animateWithDuration:1 animations:^{
        self.skipX.constant = pos;
        self.aboutX.constant = -pos;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self setCenterLoginButton];
    }];
}

-(void)setCenterLoginButton {
    [UIView animateWithDuration:1 animations:^{
        self.loginY.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentViewController:controller animated:NO completion:nil];
    }];
}

@end
