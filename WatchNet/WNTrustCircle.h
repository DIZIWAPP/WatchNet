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


@property (nonatomic, strong)   NSMutableArray* circleMembers;

@property (nonatomic, strong) id    circleOwnerID;//PFObject;


- (void)fetchTrustCircleWithCompletionBlock: (void (^)(NSError *error)) callback;

- (id) findMemberWithEmail:(NSString*) emailID;

- (id) findMemberWithPhone: (NSString*) phone;

@end
