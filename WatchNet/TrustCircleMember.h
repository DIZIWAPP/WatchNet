//
//  TrustCircleMember.h
//  WatchNet
//
//  Created by Mahesh Kumar on 6/20/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "ParseModel.h"

@interface TrustCircleMember : ParseModel

@property (nonatomic, strong) NSString*             firstName;
@property (nonatomic, strong) NSString*             lastName;
@property (nonatomic, strong) NSString*             email;
@property (nonatomic, strong) NSString*             phone;
@property (nonatomic) BOOL                          invitationSent;
@property (nonatomic, strong) CLLocation*           defaultLocation;
@property (nonatomic, strong) CLLocation*           lastLocation;
@property (nonatomic, strong) NSMutableArray*       tmpPhoneList;
@property (nonatomic, strong) NSMutableArray*       tmpEmailList;

@end
