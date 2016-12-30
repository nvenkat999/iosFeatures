//
//  AppDelegate.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 12/30/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

