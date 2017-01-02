//
//  LoginVC.h
//  ITF
//
//  Created by Impulse on 31.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *fButton;
@property (weak, nonatomic) IBOutlet UIButton *mButton;
@property (weak, nonatomic) IBOutlet UIButton *gButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mX;


@end
