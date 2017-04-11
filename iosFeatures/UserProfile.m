//
//  UserProfile.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/13/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "UserProfile.h"
#import "LoginViewController.h"

@implementation UserProfile

-(id)initWithUsername:(NSString *)oUserName andPassword:(NSString *)oPassword andFirstName:(NSString *)oFirstName andLastName:(NSString *)oLastName andEmailId:(NSString *)oEmailId andPhoneNo:(NSString *)oPhoneNo;{
    
    self = [super init];
    if(self){
        _Username = oUserName;
        _Password = oPassword;
        _FirstName = oFirstName;
        _LastName = oLastName;
        _EmailId = oEmailId;
        _PhoneNo = oPhoneNo;
        
    }
    return self;
    
}



@end
