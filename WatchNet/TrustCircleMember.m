//
//  TrustCircleMember.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/20/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "TrustCircleMember.h"

@implementation TrustCircleMember

@dynamic firstName;
@dynamic lastName;
@dynamic email;
@dynamic phone;
@dynamic invitationSent;
@dynamic defaultLocation;
@dynamic lastLocation;


+ (NSString *)parseModelClass
{
    return @"User";
}


/*
- (void) SaveToServer
{
    
    PFObject* userObject = [self toPFObject];
    
    [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Save successful");
        }else{
            NSLog([NSString stringWithFormat:@"TrustCircleMember save failed with error %@.", error.description ]);
        }
    }];
    
}

 */

@end
