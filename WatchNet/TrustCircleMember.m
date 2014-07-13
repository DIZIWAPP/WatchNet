//
//  TrustCircleMember.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/20/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "TrustCircleMember.h"

@implementation TrustCircleMember

- (id) init
{
    self = [super init];
    return  self;
}


- (id) initWithPFObject:(PFObject*) object
{
    self = [super init];
    
    if(!self)
        return nil;
    
    
    self.pfObjectID       = object[@"objectId"];
    self.firstName        = object[@"firstName"];
    self.lastName         = object[@"lastName"];
    self.emailAddresses   = object[@"emailAddresses"];
    self.phoneList        = object[@"phoneNumbers"];
    self.companyName      = @"companyName";
    self.bInvitationSent  = object[@"invitationSent"];
    return self;
    
}


-(void) updateWithPFObject: (PFObject* ) object
{
    self.firstName        = object[@"firstName"];
    self.lastName         = object[@"lastName"];
    self.emailAddresses   = object[@"emailAddresses"];
    self.phoneList        = object[@"phoneNumbers"];
    self.companyName      = @"companyName";
    self.bInvitationSent  = object[@"invitationSent"];
    
    self.pfObjectID        = object[@"objectId"];
    
}

- (PFObject*) toPFObject
{
    PFObject* pfMemberObject;
    if (self.pfObjectID &&  [self.pfObjectID isEqualToString:@""])
        pfMemberObject = [PFObject objectWithoutDataWithClassName:@"UserDetails" objectId:self.pfObjectID];
    else
       pfMemberObject = [[PFObject alloc]initWithClassName:@"UserDetails"];

//    pfMemberObject[@"objectId"]         = self.pfObjectID;
    pfMemberObject[@"invitationSent"]   = @(self.bInvitationSent);
    pfMemberObject[@"emailAddresses"]   = self.emailAddresses;
    pfMemberObject[@"phoneNumbers"]     = self.phoneList;
    pfMemberObject[@"firstName"]        = self.firstName;
    pfMemberObject[@"lastName"]         = self.lastName;
    
    
    for(PFObject* obj in self.responderToUsers)
    {
        [pfMemberObject setObject:obj forKey:@"responderTo"];
    }
    
    return pfMemberObject;
}


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

- (void) LoadFromServer
{
    
}




@end
