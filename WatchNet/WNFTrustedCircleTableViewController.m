//
//  WNFTrustedCircleTableViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/8/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNFTrustedCircleTableViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Parse/Parse.h>
#import "WNFriendTableViewController.h"
#import "TrustCircleMember.h"

#import "WNTrustCircle.h"

@interface WNFTrustedCircleTableViewController () <ABPeoplePickerNavigationControllerDelegate>
- (IBAction)onClickAdd:(id)sender;
- (IBAction)onClickEdit:(id)sender;

@property (nonatomic, strong) ABPeoplePickerNavigationController* addressBookController;

@property (nonatomic, strong) TrustCircleMember* trustedMember;
@property (nonatomic,strong) WNTrustCircle*     trustCircle;

//@property (nonatomic, strong) NSMutableArray* arrFriendsData;


- (void)showAddressBook;

@end

@implementation WNFTrustedCircleTableViewController

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
    
    self.trustCircle = [[WNTrustCircle alloc] init];

    [self.trustCircle fetchTrustCircleWithCompletionBlock:^(NSError *error){
        if (!error) {
            [self.tableView reloadData];
        }
       
    }];
    
    
    /*
    
    PFQuery* contactsQuery = [PFQuery queryWithClassName:@"userDetails"];
    [contactsQuery whereKey:@"responderTo" equalTo:[PFUser currentUser]];
    __weak typeof (self) weakSelf = self;
    [contactsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // Do something with the found objects
//            _arrFriendsData    = [objects lastObject];
            _arrFriendsData    = objects;
            
            if(_arrFriendsData != nil){
                [self.tableView reloadData];
            }
        }
    }];
     */
     
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
     

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAddressBook
{

    _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    [_addressBookController setPeoplePickerDelegate:self];

    [self presentViewController:_addressBookController animated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.trustCircle.circleMembers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trustmembercell" forIndexPath:indexPath];
    
    // Configure the cell...
  //  PFObject* object = _arrFriendsData[indexPath.row];
    TrustCircleMember* object = _trustCircle.circleMembers[indexPath.row];
    cell.textLabel.text =[ NSString stringWithFormat:@"%@, %@", object.lastName, object.firstName ];
//    cell.textLabel.text =[ NSString stringWithFormat:@"%@, %@", object[@"lastName"], object[@"firstName"] ];
//    cell.detailTextLabel.text = object[@"<#string#>"]
//
    
    return cell;
}
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    _trustedMember = self.trustCircle.circleMembers[indexPath.row];
    
    [self showFriendDetails];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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


- (IBAction)onClickAdd:(id)sender
{

    [self showAddressBook];
    
    
}

- (IBAction)onClickEdit:(id)sender
{
    
}

#pragma mark - ABPeople delegate

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController*)peoplePicker
{
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    
    return NO;
}

 - (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return  NO;
}



- (void) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return;
    
}

- (void) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{

    /*    NSMutableDictionary *contactInfoDict = [[NSMutableDictionary alloc]
                                            initWithObjects:@[@"", @"", @"", @"", @"", @"", @"", @"", @""]
                                            forKeys:@[@"firstName", @"lastName", @"mobileNumber", @"homeNumber", @"homeEmail", @"workEmail", @"address", @"zipCode", @"city"]];
  */
    
    if(!_trustedMember)
        _trustedMember = [[TrustCircleMember alloc] init];

    NSMutableDictionary* contactInfoDict = [[NSMutableDictionary alloc]
        initWithObjects:@[ @"", @"", @"", @"", @"", @"" ]
                forKeys:@[ @"firstName", @"lastName", @"mobileNumber1", @"mobileNumber2", @"emailAddress", @"emailAddress2" ]];

    NSMutableDictionary* phoneInfoDict = [[NSMutableDictionary alloc] init];

    CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);

    if (generalCFObject) {
        [contactInfoDict setObject:(__bridge NSString*)generalCFObject forKey:@"firstName"];
        _trustedMember.firstName = (__bridge NSString*)generalCFObject;
        
        CFRelease(generalCFObject);
    }

    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (generalCFObject) {
        [contactInfoDict setObject:(__bridge NSString*)generalCFObject forKey:@"lastName"];
        _trustedMember.lastName = (__bridge NSString*)generalCFObject;
        CFRelease(generalCFObject);
    }

    
    generalCFObject = ABRecordCopyValue(person, kABPersonOrganizationProperty);
    if (generalCFObject) {
       // _trustedMember. companyName = (__bridge NSString*)generalCFObject;
        CFRelease(generalCFObject);
    }

    ABMultiValueRef phonesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray* phoneNumbers = [[NSMutableArray alloc] init];
    for (int i = 0; i < ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);

        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
            [contactInfoDict setObject:(__bridge NSString*)currentPhoneValue forKey:@"Mobile"];
            [phoneNumbers addObject:(NSString*)CFBridgingRelease(currentPhoneValue)];
            [phoneInfoDict setObject:(__bridge NSString*)currentPhoneValue forKey:@"Mobile" ];
            
        }else

        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneIPhoneLabel, 0) == kCFCompareEqualTo) {
            
            [phoneNumbers addObject:(NSString*)CFBridgingRelease(currentPhoneValue)];
            [contactInfoDict setObject:(__bridge NSString*)currentPhoneValue forKey:@"iPhone"];
            [phoneInfoDict setObject:(__bridge NSString*)currentPhoneValue forKey:@"iPhone" ];
            
        }else

        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMainLabel, 0) == kCFCompareEqualTo) {
            
            [phoneNumbers addObject:(NSString*)CFBridgingRelease(currentPhoneValue)];
            [contactInfoDict setObject:(__bridge NSString*)currentPhoneValue forKey:@"Main"];
            [phoneInfoDict setObject:(__bridge NSString*)currentPhoneValue forKey:@"Main" ];
            
        }else{
            
            [phoneInfoDict setObject:(__bridge NSString*)currentPhoneValue forKey:@"Phone" ];

        }
            
        CFRelease(currentPhoneLabel);
        //CFRelease(currentPhoneValue);
    }
    CFRelease(phonesRef);
//    _trustedMember.phoneList = phoneInfoDict;
    _trustedMember.tmpPhoneList = [phoneInfoDict mutableCopy];
    _trustedMember.phone        = @"1212121212";//[phoneInfoDict objectForKey:@"iPhone"];

    ABMultiValueRef emailsRef   = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSArray* emailAddresses     = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(emailsRef);
    _trustedMember.tmpEmailList = [emailAddresses mutableCopy];
    _trustedMember.email        = [emailAddresses firstObject];

    /*
    ABMultiValueRef addressRef = ABRecordCopyValue(person, kABPersonAddressProperty);
    if (ABMultiValueGetCount(addressRef) > 0) {
        NSDictionary *addressDict = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(addressRef, 0);
        
        [contactInfoDict setObject:[addressDict objectForKey:(NSString *)kABPersonAddressStreetKey] forKey:@"address"];
        [contactInfoDict setObject:[addressDict objectForKey:(NSString *)kABPersonAddressZIPKey] forKey:@"zipCode"];
        [contactInfoDict setObject:[addressDict objectForKey:(NSString *)kABPersonAddressCityKey] forKey:@"city"];
    }
    CFRelease(addressRef);
    
    
    if (ABPersonHasImageData(person)) {
        NSData *contactImageData = (__bridge NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
        
        [contactInfoDict setObject:contactImageData forKey:@"image"];
    }
    */

   [_addressBookController dismissViewControllerAnimated:NO completion:nil];
    
    [self showFriendDetails];

    return;
}


- (void) showFriendDetails
{
    [self performSegueWithIdentifier:@"showFriendDetails" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showFriendDetails"])
    {
        
        
        NSIndexPath* indexPath =  [self.tableView indexPathForSelectedRow];
        
    //    UINavigationController* nav = sender;
        WNFriendTableViewController* friendVC = segue.destinationViewController;//[nav.viewControllers firstObject];
        friendVC.memberInfo = _trustedMember;//_trustCircle.circleMembers[indexPath.row] ;
    }
}


#if 0

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}
#endif

@end
