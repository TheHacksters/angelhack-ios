//
//  AHProfileViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHProfileViewController.h"
#import "AHModels.h"

@interface AHProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *bdayLabel;

@property (weak, nonatomic) IBOutlet UIButton *changePhoto;

@end

@implementation AHProfileViewController

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
    
    AHUser *me = [AHUser currentUser];
    self.nameLabel.text = [me getName];
    self.emailLabel.text = [me getEmail];
    
    if (me[@"image"]) {
        PFFile *imageFile = me[@"image"];
        NSData *imageData = imageFile.getData;
        UIImage *image = [UIImage imageWithData:imageData];
        [self.changePhoto setImage:image forState:UIControlStateNormal];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    
    self.bdayLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[me getBirthday]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Logout Handler
- (IBAction)performLogout:(id)sender
{
    [AHUser logOut];
    [self performSegueWithIdentifier:@"successLogout" sender:self];
}

#pragma mark - Upload Photo
- (IBAction)pickPhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [self.changePhoto setImage:chosenImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    // Convert to JPEG with 50% quality
    NSData* data = UIImageJPEGRepresentation(chosenImage, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    // Save the image to Parse
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The image has now been uploaded to Parse. Associate it with a new object
            AHUser *user = [AHUser currentUser];
            user[@"image"]=imageFile;
            
            [user saveInBackground];
        }
    }];
    
}

@end
