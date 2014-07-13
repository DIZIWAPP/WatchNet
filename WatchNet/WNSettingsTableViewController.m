//
//  WNSettingsTableViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/7/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNSettingsTableViewController.h"
#import <Parse/Parse.h>


@interface WNSettingsTableViewController () <UINavigationBarDelegate>
{
    PFObject* settingsObject;
    BOOL userWillRespond;
}
@property (weak, nonatomic) IBOutlet UISlider *sliderNotify;
@property (weak, nonatomic) IBOutlet UISlider *respondNotify;
@property (weak, nonatomic) IBOutlet UILabel *labelNotifyDistance;
@property (weak, nonatomic) IBOutlet UISwitch *switchSendPush;

@property (weak, nonatomic) IBOutlet UILabel *labelRespondDistance;
@property (weak, nonatomic) IBOutlet UISwitch *sendEmail;
@property (weak, nonatomic) IBOutlet UISwitch *switchSendSMS;
@property (weak, nonatomic) IBOutlet UISwitch *switchEnableResponder;
@property (weak, nonatomic) IBOutlet UISwitch *switchReceiveSMS;
@property (weak, nonatomic) IBOutlet UISwitch *switchReceiveEmail;
@property (weak, nonatomic) IBOutlet UISwitch *switchReceivePush;


@end

@implementation WNSettingsTableViewController



- (IBAction)onSaveSettings:(id)sender {
    [self saveSettings];
}

-(void)saveSettings
{
    
    PFUser* user = [PFUser currentUser];
    
    
    if(!settingsObject)
        settingsObject = [PFObject objectWithClassName:@"Settings"];
    
    settingsObject[@"IsResponder"] =  @(_switchEnableResponder.on);
    userWillRespond = _switchEnableResponder.on;
    settingsObject[@"CanReceiveSMS"] = @(_switchReceiveSMS.on);
    settingsObject[@"CanReceivePush"] = @(_switchReceivePush.on);
    settingsObject[@"CanReceiveEmail"] = @(_switchReceiveEmail.on);
    
    settingsObject[@"CanSendSMS"] = @(_switchSendSMS.on);
    
    settingsObject[@"CanSendPush"] = @(_switchSendPush.on);
    settingsObject[@"CanSendEmail"] = @(_sendEmail.on);
    
    settingsObject[@"WillRespondWithin"] = @([ @(_respondNotify.value) integerValue]);
    settingsObject[@"SendNotifyWithin"] = @([ @(_sliderNotify.value) integerValue]);
    
    [settingsObject setObject:user forKey:@"User"];
    
    [settingsObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            NSLog(@"Settings saved succesfully.");
            
            
        }else{
            settingsObject = nil;
            NSLog(error.description);
        }
    }];
    
    
    
}

-(void) switchValueChanged: (id)sender
{
    NSLog(@"SwitchValueChanged called.");
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
/*    if(_switchEnableResponder.on == FALSE)
    {
    }
 */
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadSettings];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSwitchResponderValueChanged:(id)sender {
    
    UISwitch* switchCtrl = sender;
    [self updateResponderUIControls:switchCtrl.on];
//    [self reloadDataAnimated:YES];

//    [self.tableView reloadData];
    // Reload all sections
    //    NSIndexSet* reloadSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self numberOfSectionsInTableView:self.tableView])];
    NSIndexSet* reloadSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 1)];
    
    [self.tableView reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}


-(void)loadSettings
{
    PFQuery* settingsQuery = [PFQuery queryWithClassName:@"Settings"];
    [settingsQuery whereKey:@"User" equalTo:[PFUser currentUser]];

    
    __weak typeof (self) weakSelf = self;
    [settingsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // Do something with the found objects
            settingsObject    = [objects lastObject];
            _switchEnableResponder.on   = [[settingsObject objectForKey:@"IsResponder"] boolValue];
            _switchReceiveSMS.on        = [[settingsObject objectForKey:@"CanReceiveSMS"] boolValue];
            _switchReceivePush.on       = [[settingsObject objectForKey:@"CanReceivePush"] boolValue];
            _switchReceiveEmail.on      = [[settingsObject objectForKey:@"CanReceiveEmail"] boolValue];
            _switchSendSMS.on           = [[settingsObject objectForKey:@"CanSendSMS"] boolValue];
            _switchSendPush.on          = [[settingsObject objectForKey:@"CanSendPush"] boolValue];
            _sendEmail.on               = [[settingsObject objectForKey:@"CanSendEmail"] boolValue];

            _respondNotify.value        = [[settingsObject objectForKey:@"WillRespondWithin"] floatValue];
            _labelRespondDistance.text = [NSString stringWithFormat:@"%.0f Kms", [_respondNotify value]];
            _sliderNotify.value         = [[settingsObject objectForKey:@"SendNotifyWithin"] floatValue];
            _labelNotifyDistance.text = [NSString stringWithFormat:@"%.0f Kms",[_sliderNotify value]];

            
            [self updateResponderUIControls:_switchEnableResponder.on];

            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.view setNeedsDisplay];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
}

-(void) updateResponderUIControls: (BOOL) isResponder
{
    userWillRespond                 = isResponder;
    _switchReceiveEmail.enabled     = isResponder;
    _switchReceivePush.enabled      = isResponder;
    _switchReceiveSMS.enabled       = isResponder;
    _respondNotify.enabled          = isResponder;
    _labelRespondDistance.enabled   = isResponder;
    
    [self reloadTableData];
    
}

-(void) reloadTableData
{
    NSIndexSet* reloadSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 1)];
    
    [self.tableView reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section == 0)
        return 4;
    else if(section == 1)
    {
        if(userWillRespond)
        {
            return 5;
            
        }else
            return 1;
    }
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


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

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)sliderValueChanged:(id)sender{
    UISlider* slide = sender;
    if(slide.tag == 1002)
    {
        _labelNotifyDistance.text = [NSString stringWithFormat:@"%.0f Kms",[slide value]];
    }
    else if(slide.tag == 1003)
    {
        _labelRespondDistance.text = [NSString stringWithFormat:@"%.0f Kms", [slide value]];
    }

}

@end
