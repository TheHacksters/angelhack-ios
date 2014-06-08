//
//  AHUser.h
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/Parse.h>
#import "AHModels.h"

@class AHCompany;

@interface AHUser : PFUser

@property (strong, nonatomic) AHCompany *selectedCompany;

- (AHUser *)initWithUsername:(NSString *)username andPassword:(NSString *)password andName: (NSString *)name andBirthday: (NSDate *)birthday;

- (void)addCompany:(AHCompany *)company;
- (NSMutableArray *)getCompanies;

- (NSString *)getObjectId;
- (NSString *)getName;
- (NSString *)getEmail;
- (NSDate *)getBirthday;
- (BOOL)isEmailVerified;

- (void)setName:(NSString *)name;
- (void)setBirthday:(NSString *)birthday;

@end
