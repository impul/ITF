//
//  FireManager.m
//  ITF
//
//  Created by Impulse on 13.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "FireManager.h"


@interface FireManager ()

@end

@implementation FireManager
+(instancetype)sharedInstance {
    static FireManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FireManager alloc] init];
    });
    return sharedInstance;
}
@end
