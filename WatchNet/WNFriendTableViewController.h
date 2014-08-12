//
//  WNFAddFriendTableViewController.h
//  WatchNet
//
//  Created by Mahesh Kumar on 6/12/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrustCircleMember.h"

@interface WNFriendTableViewController : UITableViewController

@property (nonatomic, strong) TrustCircleMember* memberInfo;
@property (nonatomic)  BOOL isEditMode;

@end
