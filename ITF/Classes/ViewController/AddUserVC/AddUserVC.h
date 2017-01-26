//
//  AddUserVC.h
//  ITF
//
//  Created by Impulse on 08.01.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@protocol ReturnRefProtocol <NSObject>

-(void)returnRefProtocol:(FIRDatabaseReference *)ref;

@end

@interface AddUserVC : UIViewController
@property (strong, nonatomic) NSDictionary *dictOfITF;
@property (weak, nonatomic) id <ReturnRefProtocol> delegate;
@end
