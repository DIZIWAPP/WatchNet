//
//  WNFBLoginViewController.h
//  WatchNet
//
//  Created by Mahesh Kumar on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNEmailSignupViewController.h"

@interface WNFBLoginViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, weak) id <authenticateCompleteDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
