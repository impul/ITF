//
//  StartScreen.h
//  ITF
//
//  Created by Impulse on 21.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartScreen : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *skipY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *skipX;

@end
