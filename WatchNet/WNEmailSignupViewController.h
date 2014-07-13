//
//  WNEmailSignupViewController.h
//  WatchNet
//
//  Created by Mahesh Kumar on 6/2/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol authenticateCompleteDelegate <NSObject>

- (void) authenticateComplete:(BOOL) successful ;

@end

//@interface WNFBLoginViewController : UIViewController<UIScrollViewDelegate,authenticateCompleteDelegate>

@interface WNEmailSignupViewController : UIViewController<authenticateCompleteDelegate, UITextFieldDelegate>


@end
