//
//  WNTrustCircle.h
//  WatchNet
//
//  Created by Mahesh Kumar on 6/25/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrustCircleMember.h"

@interface WNTrustCircle : NSObject


@property (nonatomic, strong) NSMutableArray* circleMembers;
//@property (nonatomic, strong) NSMutableArray* circleMembers;
@property (nonatomic, strong) id    circleOwnerID;//PFObject;

- (void)fetchCircleForUser: (id) ownerID withCompletionBlock: (void (^)(NSError *error)) callback;



- (void)fetchCircleForUser: (id) ownerID;

- (void)saveToServer;

-(id) findMemberWithEmail:(NSString*) emailID;

- (id)findMemberWithPhone: (NSString*) phone;

@end
