//
//  LoginViewController.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/6/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface LoginViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
