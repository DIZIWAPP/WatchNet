//
//  RescueMeUser.m
//  WatchNet
//
//  Created by Mahesh Kumar on 7/12/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "RescueMeUser.h"
#import <Parse/Parse.h>
@implementation RescueMeUser


@dynamic firstName;
@dynamic lastName;
@dynamic email;
@dynamic phone;
@dynamic invitationSent;
@dynamic defaultLocation;
@dynamic lastLocation;
@dynamic memberOfTrustCircles;
@dynamic trustCircleMembers;


+ (NSString *)parseModelClass
{
    return @"User";
}

+ (RescueMeUser*) getCurrentUser
{
    static RescueMeUser *sharedCurrentUser = nil;
    static dispatch_once_t onceToken;
    if([PFUser currentUser])
    {
        dispatch_once(&onceToken, ^{
            sharedCurrentUser = [[self alloc] initWithParseUser:[PFUser currentUser]];
        });
    }
    
    return sharedCurrentUser;
        
 
}

/*
- (id)initWithParseUser:(PFUser *)parseUser
{
    self = [super initWithParseUser:parseUser];
    return self;
}
*/

@end
