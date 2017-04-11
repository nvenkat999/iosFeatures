//
//  AppDelegate.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 12/30/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <uikit/uikit.h>
#import <Usernotifications/Usernotifications.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIStateRestoring>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly,strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly,strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) NSDate *backgroundSentTime;
- (void)saveContext;


@end

