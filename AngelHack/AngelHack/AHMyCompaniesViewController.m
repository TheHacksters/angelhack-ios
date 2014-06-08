//
//  AHMyCompaniesViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHMyCompaniesViewController.h"
#import "AHCompanyTableViewCell.h"
#import "AHMyEventsViewController.h"

@interface AHMyCompaniesViewController () <UITableViewDataSource, UITableViewDelegate, AHCompanyTableCellDelegate>

@property (strong, nonatomic) AHUser *user;
@property (strong, nonatomic) NSArray *companies;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) BOOL companiesFetched;
@property (assign, nonatomic) NSInteger numberOfCompanies;

@end

@implementation AHMyCompaniesViewController

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
    
    // Setting Up Table View
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // Parse Objects
    self.user = (AHUser *)[PFUser currentUser];

//    self.companies = [self.user getCompanies];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)refreshData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *companies = [self.user getCompanies];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.companies = companies;
            [self.tableView reloadData];
        });
    });
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

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.user getCompanies] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *companyCellIdentifier = @"AHCompanyTableViewCell";
    
    AHCompanyTableViewCell *cell;
    
    AHCompany *company = (AHCompany *)[self.companies objectAtIndex:indexPath.row];
    
    cell = (AHCompanyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:companyCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        NSLog(@"NIL CELL");
    }
    
    cell.name.text = [company getName];
    cell.numberOfUsers.text = [NSString stringWithFormat:@"%d", [company memberCount]];
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectCompanyAtIndexPath:indexPath];
}

#pragma mark - AHCompanyTableCell Delegate
- (void)companyTableCellDisclosureButtonTouchedAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectCompanyAtIndexPath:indexPath];
}

#pragma mark - Navigation
- (void)selectCompanyAtIndexPath:(NSIndexPath *)indexPath
{
    self.user.selectedCompany = [self.companies objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"pushCompanyEventsSegue" sender:self];

}

- (IBAction)logout:(id)sender {
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"some text..", @"alert", nil];
    
    PFQuery *userQuery = [PFQuery queryWithClassName:@"_User"];
    [userQuery whereKey:@"objectId" equalTo:@"zsXiJL04uK"];
    
    AHUser *targetUser = [[userQuery findObjects] objectAtIndex:0];
    
    // Create our installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"user" equalTo:targetUser];
    
    // Send push notification to query
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery]; // Set our installation query
    [push setData:data];
    [push sendPushInBackground];
}

#pragma mark - UITableView Delegate


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
