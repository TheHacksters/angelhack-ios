
//
//  AHCreateEmailTableViewCell.h
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableCellDelegate <NSObject>
@optional
- (void)deleteButtonTappedOnCell:(id)sender;
@end

@interface AHCreateEmailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (nonatomic, strong) id <TableCellDelegate> delegate;

@end