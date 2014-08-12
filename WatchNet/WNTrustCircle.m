//
//  WNTrustCircle.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/25/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNTrustCircle.h"

#import "TrustCircleMember.h"
#import <Parse/Parse.h>
#import "RescueMeUser.h"
#import "WNAppDelegate.h"

@implementation WNTrustCircle

- (void)fetchTrustCircleWithCompletionBlock: (void (^)(NSError *error)) callback;
{

    PFQuery* usersQuery         = [PFQuery queryWithClassName:@"User"];
    
    RescueMeUser* currentUser           = [RescueMeUser getCurrentUser];
    NSMutableArray* circleMemberEmails  =  currentUser.trustCircleMembers;

    //TODO check if user has permission to read user information;//PRIVACY
    [usersQuery whereKey:@"email" containedIn:circleMemberEmails];

    [usersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
        // The find succeeded.
        
        _circleMembers = nil;
        
        _circleMembers = [[NSMutableArray alloc]initWithCapacity:[objects count]];

        for(PFObject* friendDetailsObject in objects)
        {
            TrustCircleMember* cMember = [[TrustCircleMember alloc]initWithParseObject:friendDetailsObject];
            [_circleMembers addObject:cMember];
        }
        
        //make the callback
    } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
   callback(error);
}];


}

- (void)saveToServer
{
    
}

-(id) findMemberWithEmail:(NSString*) emailID
{
    
    return nil;
}

- (id)findMemberWithPhone: (NSString*) phone
{
    return nil;
}

@end
