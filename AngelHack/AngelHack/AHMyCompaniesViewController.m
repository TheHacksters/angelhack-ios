//
//  AHMyCompaniesViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHMyCompaniesViewController.h"
#import "AHCompanyTableViewCell.h"

@interface AHMyCompaniesViewController () <UITableViewDataSource, UITableViewDelegate>

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

    self.companies = [self.user getCompanies];
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
    cell.numberOfUsers.text = [NSString stringWithFormat:@"%d", [company memberCount] ];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"INDEX PATH: %d", indexPath.row);
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
