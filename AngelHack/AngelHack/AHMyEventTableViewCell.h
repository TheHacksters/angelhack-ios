//
//  AHMyEventTableViewCell.h
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHEvent.h"

@protocol AHEventCellTableCellDelegate <NSObject>
@optional
- (void)eventTableCellDisclosureButtonTouchedAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface AHMyEventTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AHEventCellTableCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *numberOfMembers;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (assign, nonatomic) AHEventType type;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end
