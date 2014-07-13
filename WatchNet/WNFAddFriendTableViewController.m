//
//  WNFAddFriendTableViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/12/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNFAddFriendTableViewController.h"
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>
#import "TrustCircleMember.h"

@interface WNFAddFriendTableViewController () <MFMailComposeViewControllerDelegate, UIActionSheetDelegate, MFMessageComposeViewControllerDelegate>
{
PFObject* friendDetailsObject;

}
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCompany;

@end

@implementation WNFAddFriendTableViewController
@synthesize memberInfo;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;

//    [self.navigationItem.rightBarButtonItem setTitle:@"Test"];
    
    friendDetailsObject = nil;
    [self queryFriendDetails];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];


}


- (void) queryFriendDetails
{
        PFQuery* settingsQuery = [PFQuery queryWithClassName:@"UserDetails"];
        [settingsQuery whereKey:@"responderTo" equalTo:[PFUser currentUser]];
    
    __weak typeof (self) weakSelf = self;
        [settingsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                // Do something with the found objects
                friendDetailsObject    = [objects lastObject];
                
                
                if(friendDetailsObject == nil)
                {
                    //                [self.view setNeedsDisplay];
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIBarButtonItem* barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onClickAdd:)];
                        weakSelf.navigationItem.rightBarButtonItem = barButton;
                        
                        UIButton* inviteBtn = (UIButton*)[weakSelf.tableView viewWithTag:1010];
                        inviteBtn.hidden = NO;
                        
                    });
                    
                }else{
                    //                [self.view setNeedsDisplay];

                
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIBarButtonItem* barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onClickAdd:)];
                        weakSelf.navigationItem.rightBarButtonItem = barButton;
                        
                        UIButton* inviteBtn = (UIButton*)[weakSelf.tableView viewWithTag:1010];
                        inviteBtn.hidden = YES;
                    
                    });

                }
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
          }
        }];
        

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"You have pressed the %@ button", [actionSheet buttonTitleAtIndex:buttonIndex]);
    NSString* buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if([buttonTitle isEqualToString:@"Send email"])
    {
        [self showComposeEmailInvitation];
        
    }else
    if([buttonTitle isEqualToString:@"Send text message"])
    {
        [self showComposeSMSInvitation];
    }
}


- (IBAction)onClickInvite:(id)sender {
 
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Send email",@"Send text message", nil];
    
    [actionSheet showInView:self.view];
}

- (void)showComposeSMSInvitation{
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = [[NSArray alloc]initWithArray:[self.memberInfo.phoneList allValues]];
    NSString *message = @" Dear, \n \n Please join me at Rescue Me community to make a difference.\
                            \n For more details check https://Rescueme.org \n \n \
                            with best regards, \n \n Mahesh";

    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}


- (void)showComposeEmailInvitation
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer =
        [[MFMailComposeViewController alloc] init];
        
        //NSArray *toRecipients = [NSArray arrayWithObjects:@"fisrtMail@example.com", @"secondMail@example.com", nil];
        NSArray* toRecipients = [NSArray arrayWithArray:self.memberInfo.emailAddresses];
        [mailComposer setToRecipients:toRecipients];
        
        [mailComposer setSubject:@"Make a difference: Join me @ RescueMe"];
        NSString *message = @" Dear, \n \n Please join me at Rescue Me community to make a difference.\
                            \n For more details check https://Rescueme.org \n \n \
                            with best regards, \n \n Mahesh";
        
        [mailComposer setMessageBody:message
                              isHTML:NO];

        mailComposer.mailComposeDelegate = self;
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}


- (IBAction)onClickAdd:(id)sender {
    
    [self saveFriendDetails];
}




- (IBAction)saveFriendDetails{
    PFUser* user = [PFUser currentUser];
    
    friendDetailsObject = [self.memberInfo toPFObject];
    
    /*
    if(!friendDetailsObject)
        friendDetailsObject = [PFObject objectWithClassName:@"UserDetails"];
    
    friendDetailsObject[@"invitationSent"]  = @(YES);
    friendDetailsObject[@"emailAddresses"]  = self.memberInfo.emailAddresses;
    friendDetailsObject[@"phoneNumbers"]    = self.memberInfo.phoneList;
    
    friendDetailsObject[@"firstName"]       = self.memberInfo.firstName;
    
    friendDetailsObject[@"lastName"]        = self.memberInfo.lastName;

     */
    
//    PFRelation *relation = [friendDetailsObject relationforKey:@"responderTo"];
  //  [relation addObject:user];
    
    [friendDetailsObject setObject:user forKey:@"responderTo"];
    
 //   [friendDetailsObject setObject:user forKey:@"rescueMeID"];
    
    [friendDetailsObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            NSLog(@"Settings saved succesfully.");
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"string" message:@"Friend details Saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            [alert show];
            
            
        }else{
            friendDetailsObject = nil;
            NSLog(error.description);
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"string" message:@"Friend details failed to save" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            [alert show];
        }
    }];
    
}

//Add <MFMailComposeViewControllerDelegate> in .h file
#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            break;
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    //return 3;   
    
    return [self calculateNumOfRows];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    int rowIndex    = indexPath.row;
    int emailCount  = [self.memberInfo.emailAddresses count];
    int phoneCount  = [self.memberInfo.phoneList count];
    int rowCount    = [self calculateNumOfRows];

    if(indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"friendinfocell" forIndexPath:indexPath];
        
        UILabel* lbl = (UILabel*)[cell viewWithTag:1004];
        lbl.text = [NSString stringWithFormat:@"%@ , %@", [memberInfo firstName], [memberInfo lastName] ];
        
        lbl = (UILabel*)[cell viewWithTag:1005];
        NSString* companyName = [memberInfo companyName];
        if (companyName == nil) {
            lbl.text = @"";
        }else
            lbl.text = [memberInfo companyName];
        
        
    }
    else if (indexPath.row == [tableView numberOfRowsInSection:0] - 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"invitecell" forIndexPath:indexPath];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
        
    }
    else if (indexPath.row > 0 && indexPath.row <= phoneCount)
    {
        int index = indexPath.row - 1;
        NSString* keyName =[memberInfo.phoneList allKeys][indexPath.row - 1];
        cell = [tableView dequeueReusableCellWithIdentifier:@"phoneinfocell" forIndexPath:indexPath];
        UILabel* lbl = (UILabel*)[cell viewWithTag:1006];
        lbl.text = keyName;
        
        lbl = (UILabel*)[cell viewWithTag:1007];
        lbl.text = [memberInfo.phoneList objectForKey:keyName];
        
    }
    else if (indexPath.row > phoneCount && indexPath.row <= (phoneCount + emailCount) )
    {
        
        int index = indexPath.row - phoneCount - 1;
        cell = [tableView dequeueReusableCellWithIdentifier:@"phoneinfocell" forIndexPath:indexPath];
        UILabel* lbl = (UILabel*)[cell viewWithTag:1006];
        lbl.text = @"email";
        
        lbl = (UILabel*)[cell viewWithTag:1007];
        lbl.text = memberInfo.emailAddresses[index];

        
    }
    
    // Configure the cell...
    
    return cell;
}


- (NSInteger) calculateNumOfRows
{
    return 2 + [self.memberInfo.emailAddresses count] + [self.memberInfo.phoneList count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [self calculateNumOfRows];
    if(indexPath.row == 0 )
    {
        return 90;
    }else
    if(indexPath.row == row - 1 )
    {
        return 120;
    }
    return 40;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
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

@end
