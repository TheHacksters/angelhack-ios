//
//  AHEventInviteTableViewCell.h
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHEvent.h"

@protocol AHEventInviteTableCellDelegate <NSObject>
@optional
- (void)eventInviteTableCellConfirmButtonTouchedAtIndexPath:(NSIndexPath *)indexPath;
- (void)eventInviteTableCellCancelButtonTouchedAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface AHEventInviteTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AHEventInviteTableCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *numberOfMembers;

@property (assign, nonatomic) AHEventType type;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end
