//
//  LoginVC.m
//  ITF
//
//  Created by Impulse on 31.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "LoginVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@import Firebase;
@import GoogleSignIn;

@interface LoginVC () <CAAnimationDelegate,GIDSignInDelegate,GIDSignInUIDelegate>
@end

@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [FBSDKAccessToken currentAccessToken];
    [UIView animateWithDuration:0.5 animations:^{
        self.fY.constant = -110;
        self.fX.constant = -110;
        self.gY.constant = -110;
        self.gX.constant = 110;
        self.mY.constant = 155.56;
        self.loginButton.backgroundColor = [UIColor blackColor];
        [self.loginButton setTitle:@"Skip" forState:UIControlStateNormal];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self moveButtonsToCenter];
    }];
}
- (IBAction)skipButton:(id)sender {
    [self showMainController];
}

-(void)moveButtonsToCenter {
    [UIView animateWithDuration:1 animations:^{
        self.fY.constant = -75;
        self.fX.constant = -75;
        self.gY.constant = -75;
        self.gX.constant = 75;
        self.mY.constant = 106;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)mainAction:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MailLoginVC"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)facebookAction:(id)sender {
    [self changeViewSize:self.fButton withAnimationRadius:500];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions: @[@"public_profile",@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                [self changeViewSize:self.fButton withAnimationRadius:50];
            } else if (result.isCancelled) {
                [self changeViewSize:self.fButton withAnimationRadius:50];
            } else {
                if ([FBSDKAccessToken currentAccessToken]) {
                    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                    [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser *user, NSError *error) {
                        [self showMainController];
                        
                    }];
                }
                
            }
        }];
    });
}

- (IBAction)googleAction:(id)sender {
    [self changeViewSize:self.gButton withAnimationRadius:500];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
        [GIDSignIn sharedInstance].delegate = self;
        [GIDSignIn sharedInstance].uiDelegate = self;
        [[GIDSignIn sharedInstance] signIn];
    });
    
    
}


-(void)changeViewSize:(UIView *)view withAnimationRadius:(NSInteger)radius {
    UIBezierPath *newPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:(-M_PI/2) endAngle:(3*M_PI/2) clockwise:YES];
    CGRect newBounds = CGRectMake(0, 0, 2 * radius, 2 * radius);
    
    CABasicAnimation* pathAnim = [CABasicAnimation animationWithKeyPath: @"path"];
    pathAnim.toValue = (id)newPath.CGPath;
    
    CABasicAnimation* boundsAnim = [CABasicAnimation animationWithKeyPath: @"bounds"];
    boundsAnim.toValue = [NSValue valueWithCGRect:newBounds];
    
    CABasicAnimation* radiusAnum = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusAnum.toValue = [NSNumber numberWithFloat:radius];
    
    CAAnimationGroup *anims = [CAAnimationGroup animation];
    anims.animations = [NSArray arrayWithObjects:pathAnim, boundsAnim, radiusAnum,nil];
    anims.removedOnCompletion = NO;
    anims.duration = 0.7f;
    anims.fillMode  = kCAFillModeForwards;
    
    [self.view bringSubviewToFront:view];
    [view.layer addAnimation:anims forKey:nil];
}

#pragma mark - Google

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error ) {
        [self changeViewSize:self.gButton withAnimationRadius:50];
    } else {
        FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:user.authentication.idToken
                                                                         accessToken:user.authentication.accessToken];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      if (error) {
                                          [self changeViewSize:self.gButton withAnimationRadius:50];
                                          return;
                                      }
                                      [self showMainController];
                                  }];
    }
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

-(void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    
}

-(void)showMainController {
    UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    [self presentViewController:navigation animated:YES completion:nil];
}


@end
