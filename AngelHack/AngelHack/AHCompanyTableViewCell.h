//
//  AHCompanyTableViewCell.h
//  AngelHack
//
//  Created by Marcelo Toledo on 6/7/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AHCompanyTableCellDelegate <NSObject>
@optional
- (void)companyTableCellDisclosureButtonTouchedAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface AHCompanyTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AHCompanyTableCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *numberOfUsers;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageActivityIndicator;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end
