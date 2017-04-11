//
//  SqlLiteDatabaseMethods.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/9/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface SqlLiteDatabaseMethods : UIViewController

+(void)ConnectDB;
+(void)CreateDBandTables;
+(void)InsertData:(NSString *)insertSQL andSuccessMessage:(NSString *)successMessage andFailureMessage:(NSString *)failureMessage;
+(void)GetData:(NSString *)getDataSQL andSuccessMessage:(NSString *)successMessage andFailureMessage:(NSString *)failureMessage;
+(void)showUIAlertMessageOnDatabase:(NSString *)message andWithTitle:(NSString *)title andInView:(UIViewController *)presentView;

@end
