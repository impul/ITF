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
        self.loginButton.layer.opacity = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self moveButtonsToCenter];
    }];
}

-(void)moveButtonsToCenter {
    [UIView animateWithDuration:1 animations:^{
        self.fY.constant = -75;
        self.fX.constant = -75;
        self.gY.constant = -75;
        self.gX.constant = 75;
        self.mY.constant = 75;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)mainAction:(id)sender {
}

- (IBAction)facebookAction:(id)sender {
    [self facebookAnimation:500];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions: @[@"public_profile",@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 [self facebookAnimation:50];
             } else if (result.isCancelled) {
                 [self facebookAnimation:50];
             } else {
                 if ([FBSDKAccessToken currentAccessToken]) {
                     FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                      credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                     [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser *user, NSError *error) {
                                                   UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
                                                   [self presentViewController:navigation animated:YES completion:nil];

                     }];
                }
                      
            }
         }];
    });
}

- (IBAction)googleAction:(id)sender {
    
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [[GIDSignIn sharedInstance] signIn];
 
}


-(void)facebookAnimation:(NSInteger)radius {
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
    
    [self.view bringSubviewToFront:self.fButton];
    [self.fButton.layer addAnimation:anims forKey:nil];
}

#pragma mark - Google

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        // ...
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
                                  [self presentViewController:navigation animated:YES completion:nil];
                                  if (error) {
                                      // ...
                                      return;
                                  }}];
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

@end
