//
//  AHCreateCompanyViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHCreateCompanyViewController.h"
#import "AHCreateEmailTableViewCell.h"
#import "AHModels.h"
#import "AHUtils.h"

@interface AHCreateCompanyViewController () <UITableViewDelegate, UITableViewDataSource, TableCellDelegate>

@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIView *companyContainerView;
@property (weak, nonatomic) IBOutlet UIView *emailContainerView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *emailTableView;

@property (strong, nonatomic) NSMutableArray *emails;
           
@end

@implementation AHCreateCompanyViewController

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
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    self.emails = [[NSMutableArray alloc] init];
    self.emailTableView.delegate = self;
    self.emailTableView.dataSource = self;
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.emailTableView.backgroundColor = [UIColor clearColor];

    //Change Placeholder Font Color
    self.companyField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // Setting Textfield Border Color
    self.companyContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:1.0f].CGColor;
    self.emailContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:0.980392f].CGColor;
    
    // Setting Signup Button State Color
    UIView *blueBackgroundView = [[UIView alloc] initWithFrame:self.createButton.frame];
    blueBackgroundView.backgroundColor = [UIColor colorWithRed:0.41960784f green:0.5725490f blue:0.666666667f alpha:1.0f];
    UIImage *blueBackground = [AHUtils imageFromView:blueBackgroundView];
    [self.createButton setBackgroundImage:blueBackground forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.emails.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (double)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableCellID";

    AHCreateEmailTableViewCell *tablecell = (AHCreateEmailTableViewCell *)[self.emailTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    tablecell.backgroundColor = [UIColor clearColor];
    tablecell.emailLabel.text = [self.emails objectAtIndex:indexPath.row];
    tablecell.delegate = self;

    return tablecell;
}

#pragma mark - Email List Manager
- (IBAction)addEmailToList:(id)sender
{
    if (![self validEmail]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Email inválido";
        NSString *message = @"Por favor, insira novamente o email.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [self.emails addObject: self.emailField.text];
    self.emailField.text = @"";
    
    [self.emailTableView reloadData];
}

- (void)deleteButtonTappedOnCell:(id)sender {
    NSIndexPath *indexpath = [self.emailTableView indexPathForCell:sender];
    [self.emails removeObjectAtIndex:indexpath.row];
    
    [self.emailTableView reloadData];
}

#pragma mark - Support Methods
- (BOOL)validEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if(![emailTest evaluateWithObject:self.emailField.text])
    {
        return NO;
    }
    return YES;
}

-(void)dismissKeyboard
{
    [self.companyField resignFirstResponder];
    [self.emailField resignFirstResponder];
    
}

#pragma mark - Status Bar Style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Dismiss Signup
- (IBAction)popViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Create Company Manager
- (IBAction)createCompany:(id)sender
{
    AHCompany *newCompany = [[AHCompany alloc] initWithName:self.companyField.text andAdmin:[AHUser currentUser]];
}

@end
