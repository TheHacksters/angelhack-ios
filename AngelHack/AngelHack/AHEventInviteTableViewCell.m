//
//  AHEventInviteTableViewCell.m
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHEventInviteTableViewCell.h"

@implementation AHEventInviteTableViewCell

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

#pragma mark - Buttons Touch
- (IBAction)confirmButtonTouch:(id)sender {
    if ([self.delegate respondsToSelector:@selector(eventInviteTableCellConfirmButtonTouchedAtIndexPath:)]) {
        [self.delegate eventInviteTableCellConfirmButtonTouchedAtIndexPath:self.indexPath];
    }
}
- (IBAction)cancelButtonTouch:(id)sender {
    if ([self.delegate respondsToSelector:@selector(eventInviteTableCellCancelButtonTouchedAtIndexPath:)]) {
        [self.delegate eventInviteTableCellCancelButtonTouchedAtIndexPath:self.indexPath];
    }
}

- (void)setType:(AHEventType)type
{
    switch (type) {
        case AHEventTypeBirthday:
            [self birthdayTab];
            break;
        case AHEventTypeMeal:
            [self mealTab];
            break;
        case AHEventTypeMeeting:
            [self meetingTab];
            break;
        case AHEventTypeSports:
            [self sportsTab];
            break;
        case AHEventTypeHappyHour:
            [self happyHourTab];
            break;
        case AHEventTypeCoffee:
            [self coffeeTab];
            break;
        default:
            break;
    }
}

- (void)happyHourTab {
    self.image.image = [UIImage imageNamed:@"ic_big_beer"];
    self.image.backgroundColor = [UIColor colorWithRed:202.0f/255.0f green:158.0f/255.0f blue:72.0f/255.0f alpha:1.0f];
}
- (void)sportsTab {
    self.image.image = [UIImage imageNamed:@"ic_big_sport"];
    self.image.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:156.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
}
- (void)coffeeTab {
    self.image.image = [UIImage imageNamed:@"ic_big_coffee"];
    self.image.backgroundColor = [UIColor colorWithRed:84.0f/255.0f green:45.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
}
- (void)birthdayTab {
    self.image.image = [UIImage imageNamed:@"ic_big_birthday"];
    self.image.backgroundColor = [UIColor colorWithRed:136.0f/255.0f green:84.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
}
- (void)meetingTab {
    self.image.image = [UIImage imageNamed:@"ic_big_meeting"];
    self.image.backgroundColor = [UIColor colorWithRed:56.0f/255.0f green:115.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
}
- (void)mealTab {
    self.image.image = [UIImage imageNamed:@"ic_small_meal"];
    self.image.backgroundColor = [UIColor colorWithRed:144.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
}

@end
