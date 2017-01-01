//
//  LoginVC.m
//  ITF
//
//  Created by Impulse on 31.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "LoginVC.h"
#import "FB"

@interface LoginVC () <CAAnimationDelegate>

@end

@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    [self facebookAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (IBAction)googleAction:(id)sender {
}


-(void)facebookAnimation {
    CGFloat radius = self.view.frame.size.height;
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


@end
