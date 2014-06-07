//
//  AHUser.h
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/Parse.h>
#import "AHModels.h"

@interface AHUser : PFUser

- (AHUser *)initWithUsername:(NSString *)username andPassword:(NSString *)password andName: (NSString *)name andBirthday: (NSString *)birthday;

@end
