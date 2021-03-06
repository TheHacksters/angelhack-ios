//
//  AHCompany.h
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/Parse.h>
#import "AHModels.h"

@class AHUser;

@interface AHCompany : PFObject <PFSubclassing>

@property (assign, nonatomic) NSInteger count;

+ (NSString *)parseClassName;

- (AHCompany *)initWithName:(NSString *)name andAdmin:(AHUser *)admin;
- (NSString *)getName;
- (AHUser *)getAdmin;

- (void)setName:(NSString *)name;
- (void)setAdmin:(AHUser *)admin;

- (NSInteger)memberCount;

- (void)addMember:(AHUser *)user;
- (void)batchInvite:(NSArray *)emailList;

@end
