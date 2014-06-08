 //
//  AHMyEventsViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHMyEventsViewController.h"
#import "AHEventInviteTableViewCell.h"
#import "AHMyEventTableViewCell.h"
#import "AHEvent.h"
#import "AHUser.h"

@interface AHMyEventsViewController () <UITableViewDataSource, UITableViewDelegate, AHEventCellTableCellDelegate, AHEventInviteTableCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *eventInvitations;
@property (strong, nonatomic) NSArray *events;

@property (strong, nonatomic) AHUser *user;

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation AHMyEventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Table View Setup
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.user = [AHUser currentUser];

    self.events = @[];
    self.eventInvitations = @[];
    
    NSString *title = [self.user.selectedCompany getName];
    self.title = title;
    self.navigationItem.title = title;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)refreshData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PFQuery *query = [PFQuery queryWithClassName:@"Event"];
        [query whereKey:@"company" equalTo:self.user.selectedCompany];
        [query whereKey:@"invited" equalTo:self.user];
        NSArray *invitedEvents = [query findObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.eventInvitations = invitedEvents;
            [self.tableView reloadData];
        });
        query = [PFQuery queryWithClassName:@"Event"];
        [query whereKey:@"company" equalTo:self.user.selectedCompany];
        [query whereKey:@"confirmed" equalTo:self.user];
        NSArray *events = [query findObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.events = events;
            [self.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.eventInvitations count];
    } else {
        return [self.events count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *eventInviteCellIdentifier = @"AHEventInviteTableViewCell";
    static NSString *eventCellIdentifier = @"AHMyEventTableViewCell";
    
    NSString *identifier;
    AHEvent *event;
    
    if (indexPath.section == 0) {
        event = (AHEvent *)[self.events objectAtIndex:indexPath.row];
        identifier = eventInviteCellIdentifier;
        AHEventInviteTableViewCell *cell = (AHEventInviteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.name.text = [event getName];
        cell.numberOfMembers.text = [NSString stringWithFormat:@"%d", [event invitedMembersCount]];
        cell.indexPath = indexPath;
        cell.delegate = self;
        cell.type = [event getType];
        return cell;
        
    } else {
        event = (AHEvent *)[self.events objectAtIndex:indexPath.row];
        identifier = eventCellIdentifier;
        AHMyEventTableViewCell *cell = (AHMyEventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.name.text = [event getName];
        cell.numberOfMembers.text = [NSString stringWithFormat:@"%d", [event confirmedMembersCount]];
        cell.indexPath = indexPath;
        cell.delegate = self;
        cell.type = [event getType];
        return cell;
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectEventAtIndexPath:indexPath];
}

#pragma mark - AHEventTableCell Delegate
- (void)companyTableCellDisclosureButtonTouchedAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectEventAtIndexPath:indexPath];
}

#pragma mark - AHEventInviteTableCell Delegate
- (void)eventInviteTableCellCancelButtonTouchedAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Canceld at IndexPath(%d, %d)", indexPath.section, indexPath.row);
}

- (void)eventInviteTableCellConfirmButtonTouchedAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Confirmed at IndexPath(%d, %d)", indexPath.section, indexPath.row);
}


#pragma mark - Navigation
- (void)selectEventAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected Event at IndexPath(%d, %d)", indexPath.section, indexPath.row);
    //self.user.selectedCompany = [self.companies objectAtIndex:indexPath.row];
    //[self performSegueWithIdentifier:@"pushCompanyEventsSegue" sender:self];
}

#pragma mark - Status Bar Style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Cancel Event Creation
- (IBAction)popViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
