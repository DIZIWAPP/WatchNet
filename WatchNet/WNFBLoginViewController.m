//
//  WNFBLoginViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNFBLoginViewController.h"
#import "WNEmailSignupViewController.h"
#import "WNFEmailSigninViewController.h"
#import <Parse/Parse.h>

#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

@interface WNFBLoginViewController ()
//@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;
- (IBAction)onSignInClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;

@end

@implementation WNFBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    /*
    NSInteger statusbarHeight = 0;
    if(IS_IOS7)
        statusbarHeight = 20;
    
    self.uzysSMenu = [[UzysSlideMenu alloc] initWithItems:@[item0,item1,item2, item3]];
    self.uzysSMenu.frame = CGRectMake(self.uzysSMenu.frame.origin.x, self.uzysSMenu.frame.origin.y+ statusbarHeight, self.uzysSMenu.frame.size.width, self.uzysSMenu.frame.size.height);
    
    [self.view addSubview:self.uzysSMenu];
    self.navigationController.navigationBarHidden = YES;
     */

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onCancel:(id)sender {

    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)onSignInClick:(id)sender {
    
    
    if([_userEmail.text length] == 0 ||
       [_userPassword.text length] == 0)
    {
        return;
    }
    
    
    [PFUser logInWithUsernameInBackground:_userEmail.text password:_userPassword.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"Login successful");
                                            [self.delegate authenticateComplete:true];

                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog([NSString stringWithFormat:(@"error %@", error.description) ]);
                                            [self showError:[NSString stringWithFormat:(@"error %@", error.description) ]];
                                        }
                                    }];

    
}

-(void)showError:(NSString*) errMessage
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Sign in failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
    
    [alertView show];
}

@end
