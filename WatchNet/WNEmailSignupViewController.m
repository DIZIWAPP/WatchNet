//
//  WNEmailSignupViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/2/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNEmailSignupViewController.h"
#import <Parse/Parse.h>
#import "WNFBLoginViewController.h"
#import "WNAppDelegate.h"

@interface WNEmailSignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;


@end



@implementation WNEmailSignupViewController

- (void) viewDidLoad
{
  //  self.tableView.backgroundColor = [UIColor redColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor purpleColor];
    
    _userPhone.delegate = self;
}

- (IBAction)onSignupClick:(id)sender {
    
    
    if([_userEmail.text length] == 0 ||
        [_userPassword.text length] == 0 ||
       [_userPhone.text length] == 0)
    {
        [self showError:@"Fields should not be empty"];
        return;
    }
    
    PFUser *user    = [PFUser user];
    user.username   = _userEmail.text;
    user.password   = _userPassword.text;
    user.email      = _userEmail.text;
    
    // other fields can be set just like with PFObject
    user[@"phone"] = _userPhone.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSLog(@"Sign up successful");
            [self SignInCompleted];
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            [self showError: errorString];
            NSLog(@"%@",errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (void) authenticateComplete:(BOOL) successful
{
//    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Complete" message:@"Complete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
    
    //[alertView show];
    if([PFUser currentUser])
    {
        [self SignInCompleted];
        
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
    
}

-(void) SignInCompleted
{
   
    WNAppDelegate* appDelegate =  (WNAppDelegate*)[UIApplication sharedApplication];
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)showError:(NSString*) errMessage
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Sign up failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
    
    [alertView show];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showEmailSignIn"])
    {
        WNFBLoginViewController* signinVC = segue.destinationViewController;
        
        signinVC.delegate = self;
        
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField.tag == 1001)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        NSString *decimalString = [components componentsJoinedByString:@""];
        
        NSUInteger length = decimalString.length;
        BOOL hasLeadingOne = length > 0 && [decimalString characterAtIndex:0] == '1';
        
        if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
            textField.text = decimalString;
            return NO;
        }
        
        NSUInteger index = 0;
        NSMutableString *formattedString = [NSMutableString string];
        
        if (hasLeadingOne) {
            [formattedString appendString:@"1 "];
            index += 1;
        }
        
        if (length - index > 3) {
            NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"(%@) ",areaCode];
            index += 3;
        }
        
        if (length - index > 3) {
            NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"%@-",prefix];
            index += 3;
        }
        
        NSString *remainder = [decimalString substringFromIndex:index];
        [formattedString appendString:remainder];
        
        textField.text = formattedString;
        
        return NO;
    }
    return  YES;
}


@end
