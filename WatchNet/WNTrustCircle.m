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

@implementation WNTrustCircle

- (void)fetchCircleForUser: (id) ownerID withCompletionBlock: (void (^)(NSError *error)) callback;
{

    PFQuery* settingsQuery = [PFQuery queryWithClassName:@"UserDetails"];
    [settingsQuery whereKey:@"responderTo" equalTo:[PFUser currentUser]];

    __weak typeof (self) weakSelf = self;
    [settingsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
        // The find succeeded.
        
        _circleMembers = nil;
        
        _circleMembers = [[NSMutableArray alloc]initWithCapacity:[objects count]];

        for(PFObject* friendDetailsObject in objects)
        {
            TrustCircleMember* cMember = [[TrustCircleMember alloc]initWithPFObject:friendDetailsObject];
            [_circleMembers addObject:cMember];
        }
        
        //make the callback
        callback(error);
        /*
         
        for(PFObject* friendDetailsObject in objects)
        {
            // Do something with the found objects
           // friendDetailsObject    = [objects lastObject];
            if(friendDetailsObject == nil)
            {
                //                [self.view setNeedsDisplay];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIBarButtonItem* barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onClickAdd:)];
                    weakSelf.navigationItem.rightBarButtonItem = barButton;
                    
                    UIButton* inviteBtn = (UIButton*)[weakSelf.tableView viewWithTag:1010];
                    inviteBtn.hidden = NO;
                    
                });
                
            }else{
                //                [self.view setNeedsDisplay];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIBarButtonItem* barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onClickAdd:)];
                    weakSelf.navigationItem.rightBarButtonItem = barButton;
                    
                    UIButton* inviteBtn = (UIButton*)[weakSelf.tableView viewWithTag:1010];
                    inviteBtn.hidden = YES;
                    
                });
                
            }
            
         
        
        }

         */
    } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
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
