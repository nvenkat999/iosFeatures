//
//  SqlLiteDatabaseMethods.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/9/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "SqlLiteDatabaseMethods.h"
#import "sqlite3.h"
#import "LoginViewController.h"

@interface SqlLiteDatabaseMethods ()

@end

@implementation SqlLiteDatabaseMethods

+(void)ConnectDB{
    
}

+(void)CreateDBandTables{
    
    NSString *databasePath;
    sqlite3 *DB;
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Get the Directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the Path to keep the database
    
    databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"PokerDatabase.db"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"This is database path %@",databasePath);
    if ([fileManager fileExistsAtPath:databasePath] == NO) {
        
        const char *dbPath = [databasePath UTF8String];
        if (sqlite3_open(dbPath, &(DB))==SQLITE_OK) {
            char *errorMessage;
            //const char *createSession = "CREATE TABLE IF NOT EXISTS sessions (ID INTEGER PRIMARY KEY AUTOINCREMENT,Name  TEXT, Location TEXT, DateCreated TEXT)";
            const char *createUsers = "CREATE TABLE IF NOT EXISTS Users (ID INTEGER PRIMARY KEY AUTOINCREMENT,Username  TEXT,Password TEXT,FirstName TEXT,LastName TEXT, PhoneNo TEXT, EmailID TEXT)";
            const char *createTransactions = "CREATE TABLE IF NOT EXISTS Transactions (ID INTEGER PRIMARY KEY AUTOINCREMENT,SessionID TEXT NOT NULL, FromUser TEXT, ToUser TEXT, txAmount TEXT,txDateTime  TEXT,fdeleted TEXT)";
            
           /* if (sqlite3_exec(DB, createSession, NULL, NULL, &errorMessage)!=SQLITE_OK) {
                //[self showUIAlertMessageOnDatabase:@"Cannot create seeions table" andWithTitle:@"Error" andInView:];
            } */
            if (sqlite3_exec(DB, createUsers, NULL, NULL, &errorMessage)!=SQLITE_OK) {
                NSLog(@"Cant create Users table");
            }
            if (sqlite3_exec(DB, createTransactions, NULL, NULL, &errorMessage)!=SQLITE_OK) {
                NSLog(@"Cant create Transactions table");
            }
            sqlite3_close(DB);
        }
        else {
            NSLog(@"Failed to create table");
        }
    }
    
}




+(void)InsertData:(NSString *)insertSQL andSuccessMessage:(NSString *)successMessage andFailureMessage:(NSString *)failureMessage {
    
    NSString *databasePath;
    sqlite3 *DB;
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Get the Directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the Path to keep the database
    
    databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"PokerDatabase.db"]];
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if (sqlite3_open(dbPath, &DB)==SQLITE_OK) {
        const char *insert_statement = [insertSQL UTF8String];
        sqlite3_prepare_v2(DB, insert_statement, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            NSLog(@"%@",successMessage);
        }
        else{
            NSLog(@"%@",failureMessage);
        }
        sqlite3_close(DB);
    }
    
}


+(void)GetData:(NSString *)getDataSQL andSuccessMessage:(NSString *)successMessage andFailureMessage:(NSString *)failureMessage {
    
    NSString *databasePath;
    sqlite3 *DB;
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Get the Directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the Path to keep the database
    
    databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"PokerDatabase.db"]];
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if (sqlite3_open(dbPath, &DB)==SQLITE_OK) {
        const char *getData_statement = [getDataSQL UTF8String];
        sqlite3_prepare_v2(DB, getData_statement, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            NSLog(@"%@",successMessage);
        }
        else{
            NSLog(@"%@",failureMessage);
        }
        sqlite3_close(DB);
        
    }
    
}


+(void)showUIAlertMessageOnDatabase:(NSString *)message andWithTitle:(NSString *)title andInView:(UIViewController *)presentView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [alert addAction:defaultAction];
    [presentView presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
