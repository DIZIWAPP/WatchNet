//
//  TrustCircleMember.h
//  WatchNet
//
//  Created by Mahesh Kumar on 6/20/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface TrustCircleMember : NSObject

- (id) initWithPFObject:(PFObject*) object;

- (PFObject*) toPFObject;

@property (nonatomic, strong) NSString*             pfObjectID;
@property (nonatomic, strong) NSString*             firstName;
@property (nonatomic, strong) NSString*             lastName;
@property (nonatomic, strong) NSString*             companyName;
@property (nonatomic, strong) NSArray*              emailAddresses;
@property (nonatomic, strong) NSMutableDictionary*  phoneList;
@property (nonatomic, assign) BOOL                  bInvitationSent;

@property (nonatomic,strong) NSMutableArray*        responderToUsers;


- (void) SaveToServer;

- (void) LoadFromServer;




@end
