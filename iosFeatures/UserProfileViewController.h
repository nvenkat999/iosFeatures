//
//  UserProfileViewController.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/28/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface UserProfileViewController : UITableViewController<UITextFieldDelegate, UITextViewDelegate>

@property (weak,nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) NSArray *inputFields;

@property (strong, nonatomic) NSArray *inputFieldsDelegates;

@property (strong, nonatomic) NSMutableArray * loginUserData;

@property (strong, nonatomic) NSString *usernameString;

@end
