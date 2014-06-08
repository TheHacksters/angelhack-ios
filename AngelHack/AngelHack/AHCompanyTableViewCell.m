//
//  AHCompanyTableViewCell.m
//  AngelHack
//
//  Created by Marcelo Toledo on 6/7/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHCompanyTableViewCell.h"

@implementation AHCompanyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    for (UIView *currentView in self.subviews) {
        if ([NSStringFromClass([currentView class]) isEqualToString:@"UITableViewCellScrollView"]) {
            UIScrollView *svTemp = (UIScrollView *) currentView;
            [svTemp setDelaysContentTouches:NO];
            break;
        }
    }
    
    self.name.clipsToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
