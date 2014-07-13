//
//  WNFEmailSigninViewController.h
//  WatchNet
//
//  Created by Mahesh Kumar on 6/5/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNFBLoginViewController.h"
@interface WNFEmailSigninViewController : UIViewController

@property (nonatomic, weak) id<authenticateCompleteDelegate> delegate;

@end
