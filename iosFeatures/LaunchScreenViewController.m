//
//  LaunchScreenViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/5/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "LoginViewController.h"
#import "SqlLiteDatabaseMethods.h"
#import "LearningMethods.h"
#import "AppDelegate.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController
@synthesize fetchedResult;


- (void)viewDidLoad {
    [super viewDidLoad];
    [SqlLiteDatabaseMethods CreateDBandTables];
    [self fetchResults];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootViewControllerAnimated) name:@"popToRoot" object:nil];

    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    //NSLog(@"Fecthed result is %@",fetchedResult);
    if (([[fetchedResult valueForKey:@"autoLogin"] intValue])==1) {
        NSLog(@"AutoLogin is true");
        UIStoryboard * homeScreenStoryBoard = [UIStoryboard storyboardWithName:@"HomeScreenStoryBoard" bundle:nil];
        UIViewController *homeViewController = [homeScreenStoryBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        //[self.navigationController pushViewController:homeViewController animated:YES];
        [self presentViewController:homeViewController animated:YES completion:nil];
    }
    else if (([[fetchedResult valueForKey:@"enableTouchID"] intValue])==1){
        NSLog(@"TouchID is true");
        UIStoryboard *aLoginStoryBoard = [UIStoryboard storyboardWithName:@"LoginStoryBoard" bundle:nil];
        
        LoginViewController *loginController=[aLoginStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginController.useTouchID= @"YES";
        [self presentViewController:loginController animated:YES completion:nil];
        
    }
    else{
        UIStoryboard *aLoginStoryBoard = [UIStoryboard storyboardWithName:@"LoginStoryBoard" bundle:nil];
        UINavigationController *loginController=[aLoginStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //loginController.useTouchID= @"YES";
        
        //[self presentViewController:loginController animated:YES completion:nil];
        [self.navigationController pushViewController:loginController animated:YES];
        
    //[self.navigationController presentViewController:loginController animated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"memory warning received");
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

# pragma mark Fetching UserAttributes

-(void)fetchResults {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserAttributes" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"limit=1"];
    //[fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    [fetchRequest setFetchLimit:1];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastLoggedIn"
                                                                   ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if ([fetchedObjects count] == nil) {
        NSLog(@"Fetch Object is empty");
    }else{
        
        fetchedResult = [fetchedObjects objectAtIndex:0];
        NSString * text= [fetchedResult valueForKey:@"username"];
        NSData *dates=[fetchedResult valueForKey:@"lastLoggedIn"];
        NSNumber *autologintext = [fetchedResult valueForKey:@"autoLogin"];
        NSNumber *useTouchIDtext = [fetchedResult valueForKey:@"enableTouchID"];
        NSLog(@"%@ logged in at %@ and autologin is %@ and touchID is %@",text,dates,autologintext,useTouchIDtext);
        NSLog(@"this is fetched result %@",fetchedResult);
    }
    
}




@end
