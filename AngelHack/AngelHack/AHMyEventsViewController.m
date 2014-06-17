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

#import <QuartzCore/QuartzCore.h>

#define TABLEVIEW_SECTION_HEADER_HEIGHT 32
#define TABLEVIEW_SECTION_HEADER_FONT_SIZE 15

@interface AHMyEventsViewController () <UITableViewDataSource, UITableViewDelegate, AHEventCellTableCellDelegate, AHEventInviteTableCellDelegate> {
    BOOL _firsFetchRetruned;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *eventInvitations;
@property (strong, nonatomic) NSArray *events;

@property (strong, nonatomic) AHUser *user;

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

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
    self.navItem.title = title;
    
    // Bottom view Shadow
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bottomView.bounds];
    self.bottomView.layer.masksToBounds = NO;
    self.bottomView.layer.shadowColor = self.navBar.barTintColor.CGColor;//[UIColor blackColor].CGColor;
    self.bottomView.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.bottomView.layer.shadowOpacity = 0.9f;
    self.bottomView.layer.shadowRadius = 2.0f;
    self.bottomView.layer.shadowPath = shadowPath.CGPath;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)refreshData
{
//    [self makeRequest];
    _firsFetchRetruned = NO;
    PFQuery *invitesQuery = [PFQuery queryWithClassName:@"Event"];
    [invitesQuery whereKey:@"company" equalTo:self.user.selectedCompany];
    [invitesQuery whereKey:@"invited" equalTo:self.user];
    [invitesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.eventInvitations = objects;
        [self reloadIfDataFetched];
        _firsFetchRetruned = YES;
    }];
    
    PFQuery *eventsQuery = [PFQuery queryWithClassName:@"Event"];
    [eventsQuery whereKey:@"company" equalTo:self.user.selectedCompany];
    [eventsQuery whereKey:@"confirmed" equalTo:self.user];
    [eventsQuery orderByAscending:@"date"];
    [eventsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.events = objects;
        [self reloadIfDataFetched];
        _firsFetchRetruned = YES;
    }];
}

- (void)makeRequest
{
    PFQuery *invitesQuery = [PFQuery queryWithClassName:@"Event"];
    [invitesQuery whereKey:@"invited" equalTo:self.user];
    PFQuery *eventsQuery = [PFQuery queryWithClassName:@"Event"];
    [eventsQuery whereKey:@"confirmed" equalTo:self.user];
    
    PFQuery *compoundQuery = [PFQuery orQueryWithSubqueries:@[invitesQuery, eventsQuery]];
    [compoundQuery whereKey:@"company" equalTo:self.user.selectedCompany];
    [compoundQuery orderByAscending:@"date"];
    [compoundQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Error %@", error);
        } else {
            NSLog(@"Events Fetched!");
            [self filterResults:objects];
        }
    }];
}

- (void)filterResults:(NSArray *)resutls
{
    // No futuro fazer um js no cloud code que retorna o array ja filtrado.
    for (AHEvent *event in resutls) {
        //
        NSDate *date = event[@"date"];
        //date
    }
}

- (void)reloadIfDataFetched
{
    if (_firsFetchRetruned) {
        [self.tableView reloadData];
    }
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
        event = (AHEvent *)[self.eventInvitations objectAtIndex:indexPath.row];
        identifier = eventInviteCellIdentifier;
        AHEventInviteTableViewCell *cell = (AHEventInviteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.name.text = [event getName];
        cell.numberOfMembers.text = [NSString stringWithFormat:@"%d", [event confirmedMembersCount]];
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
        cell.date.text = [event getDateString];
        return cell;
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectEventAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerContainerView;
    UIView *headerView;
    
    if ([tableView numberOfRowsInSection:section] > 0) {
    
        // Header Container View
        headerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, TABLEVIEW_SECTION_HEADER_HEIGHT)];
        headerContainerView.backgroundColor = [UIColor clearColor];
    
        // Header View
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, TABLEVIEW_SECTION_HEADER_HEIGHT - 5.0f)];
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:headerView.bounds];
        headerView.layer.masksToBounds = NO;
        headerView.layer.shadowColor = self.navBar.barTintColor.CGColor;//[UIColor blackColor].CGColor;
        headerView.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
        headerView.layer.shadowOpacity = 0.9f;
        headerView.layer.shadowRadius = 3.0f;
        headerView.layer.shadowPath = shadowPath.CGPath;
        
        headerView.backgroundColor = self.view.backgroundColor;
    
        [headerContainerView addSubview:headerView];
    
        // Header Label
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, tableView.frame.size.width, TABLEVIEW_SECTION_HEADER_FONT_SIZE)];
        headerLabel.font = [UIFont italicSystemFontOfSize:16];
        headerLabel.textColor = [UIColor whiteColor];
        if (section == 0) {
            headerLabel.text = @"New Events";
        } else {
            headerLabel.text = @"My Events";
        }
        [headerLabel sizeToFit];
        [headerView addSubview:headerLabel];
        
        // Header Line
        CGFloat x = CGRectGetMaxX(headerLabel.frame) + 2;
        CGFloat y = CGRectGetMaxY(headerLabel.frame) - 5;
        CGFloat width = tableView.frame.size.width - x;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 1.0f)];
        lineView.backgroundColor = [UIColor whiteColor];
        
        [headerView addSubview:lineView];
        
    } else {
        headerContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    }

    return headerContainerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLEVIEW_SECTION_HEADER_HEIGHT;
}

#pragma mark - AHEventTableCell Delegate
- (void)companyTableCellDisclosureButtonTouchedAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectEventAtIndexPath:indexPath];
}

#pragma mark - AHEventInviteTableCell Delegate
- (void)eventInviteTableCellCancelButtonTouchedAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Canceld at IndexPath(%ld, %ld)", indexPath.section, indexPath.row);
}

- (void)eventInviteTableCellConfirmButtonTouchedAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Confirmed at IndexPath(%ld, %ld)", indexPath.section, indexPath.row);
}


#pragma mark - Navigation
- (void)selectEventAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Selected Event at IndexPath(%ld, %ld)", indexPath.section, indexPath.row);
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
    [self.navigationController popViewControllerAnimated:YES];
}


@end
