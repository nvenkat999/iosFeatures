//
//  LoginViewController.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/6/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <LocalAuthentication/LocalAUthentication.h>

@interface LoginViewController : UITableViewController<NSFetchedResultsControllerDelegate, UITextFieldDelegate,UITextViewDelegate>

@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong,nonatomic) NSString *useTouchID;
@property  UIActivityIndicatorView *activityIndicator;

@end
