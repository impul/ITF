//
//  FireManager.h
//  ITF
//
//  Created by Impulse on 13.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
@import FirebaseDatabase;

@interface FireManager : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;

+(instancetype)sharedInstance;

@end
