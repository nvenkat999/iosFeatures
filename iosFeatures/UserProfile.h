//
//  UserProfile.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/13/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

-(id)initWithUsername:(NSString *)oUserName andPassword:(NSString *)oPassword andFirstName:(NSString *)oFirstName andLastName:(NSString *)oLastName andEmailId:(NSString *)oEmailId andPhoneNo:(NSString *)oPhoneNo;

@property(strong, nonatomic) NSString *Username;
@property(strong, nonatomic) NSString *Password;
@property(strong, nonatomic) NSString *FirstName;
@property(strong, nonatomic) NSString *LastName;
@property(strong, nonatomic) NSString *PhoneNo;
@property(strong, nonatomic) NSString *EmailId;

@end
