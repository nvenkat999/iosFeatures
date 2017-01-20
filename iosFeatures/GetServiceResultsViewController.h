//
//  GetServiceResultsViewController.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/28/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetServiceResultsViewController : UITableViewController<UITabBarDelegate,UITableViewDataSource,UISearchBarDelegate,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * jsonData;
@property (nonatomic, strong) NSMutableArray * serviceResultsData;
@property (nonatomic,strong) NSMutableArray *displayData;
@property (nonatomic, strong) NSString * OptionSelected;
@property (nonatomic, strong) NSTimer *times;
@property (nonatomic, strong) IBOutlet UISearchBar *testSearchBar;
@property (nonatomic, strong) IBOutlet UITableView *atableView;

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UIView *activityIndicatorView;
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UILabel *testLabel;



@end
