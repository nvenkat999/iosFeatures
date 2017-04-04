//
//  GetServiceResultViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/20/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "GetServiceResultViewController.h"
#import "GetServiceDetailViewController.h"
#import "GetServiceResultsObject.h"
#import "GetServiceViewController.h"
#import "GetServiceCell.h"

@interface GetServiceResultViewController ()


@end

@implementation GetServiceResultViewController


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    _searchResultsBar.delegate = self;
    self.title = _OptionSelected;

    [self maintainThreads];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

/*
 -(void)viewDidAppear:(BOOL)animated{
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
 dispatch_async(dispatch_get_main_queue(), ^{
 [self startAnimatingView];
 });
 //Implement code here
 //wait(5);
 [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
 
 sleep(5);
 dispatch_async(dispatch_get_main_queue(), ^{
 [self stopAnimating];
 [[UIApplication sharedApplication]endIgnoringInteractionEvents];
 });
 
 });
 
 } */

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_displayData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.row ==0){
//        SearchBarCellClass  *searchCell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
//        searchCell.searchResultsBar.delegate = self;
//            return searchCell;
//        
//    }
    
    GetServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceResultsCell" forIndexPath:indexPath];
    GetServiceResultsObject *individualObject = [_displayData objectAtIndex:(indexPath.row)];
   // cell.textLabel.text = individaulObject.Title;
    cell.cellTitle.text = individualObject.Title;
    NSString *strImageData= individualObject.Image[0];
   NSData * imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:strImageData]];
    //NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strImageData]];
    //NSData * imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:individaulObject.Image[0]]];
    cell.cellImage.image = [UIImage imageWithData:imageData];
    // Configure the cell...
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showDetailSegue"]) {
        GetServiceDetailViewController *detailView = [segue destinationViewController];
        NSIndexPath *indexPath = [self.atableView indexPathForSelectedRow];
        NSInteger row = [indexPath row];
        detailView.detailData = @[_displayData[row]];
    }
}


-(void)getServiceData{
    //    [self startAnimatingView];
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            //[self startAnimatingView];
    //            });
    //Implement code here
    //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    NSLog(@"this is activity indicator test");
    
    NSString *smallOptionSelected = _OptionSelected.localizedLowercaseString;
    NSString *FinalOptionSelected = [smallOptionSelected stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *UrlString = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/top%@/limit=100/json",FinalOptionSelected];
    
    NSURL *otherUrl = [NSURL URLWithString:UrlString];
    
    NSData *otherData = [NSData dataWithContentsOfURL:otherUrl];
    
    
    NSDictionary *jsonrawData = [NSJSONSerialization JSONObjectWithData:otherData options:kNilOptions error:nil];
    
    NSDictionary *feed = [jsonrawData objectForKey:@"feed"];
    
    _jsonData = [feed objectForKey:@"entry"];
    _serviceResultsData = [[NSMutableArray alloc]init];
    
    
    for (int j=0;j< _jsonData.count;j++) {
        NSDictionary *dictTitle = [[_jsonData objectAtIndex:j]objectForKey:@"title"];
        NSString *objTitle = [dictTitle objectForKey:@"label"];
        NSDictionary *dictPrice = [[_jsonData objectAtIndex:j]objectForKey:@"im:price"];
        NSString * objPrice = [dictPrice objectForKey:@"label"];
        NSDictionary *dictCategory = [[_jsonData objectAtIndex:j]objectForKey:@"category"];
        NSDictionary *dict2Category = [dictCategory objectForKey:@"attributes"];
        NSString *objCategory = [dict2Category objectForKey:@"label"];
        NSDictionary *dictArtist = [[_jsonData objectAtIndex:j]objectForKey:@"im:artist"];
        NSString *objArtist = [dictArtist objectForKey:@"label"];
        
        NSMutableArray * arrayImagesRawData = [[_jsonData objectAtIndex:j]valueForKey:@"im:image"];
        NSMutableArray * objArrayImages = [[NSMutableArray alloc]init] ;
        for (int k =0; k<arrayImagesRawData.count ; k++) {
            NSDictionary *dictImg = [arrayImagesRawData objectAtIndex:k];
            NSString *objImg = [dictImg objectForKey:@"label"];
            [objArrayImages addObject:objImg];
            
        }
        
        NSString *objLink;
        if ([[[_jsonData objectAtIndex:j]objectForKey:@"link"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictLink = [[_jsonData objectAtIndex:j]objectForKey:@"link"];
            NSDictionary *dictLink2 = [dictLink objectForKey:@"attributes"];
            objLink = [dictLink2 objectForKey:@"href"];
        } else {
            NSMutableArray *arrayLink = [[_jsonData objectAtIndex:j]objectForKey:@"link"];
            NSDictionary *adictLink = [arrayLink objectAtIndex:0];
            NSDictionary *adicLink2 = [adictLink objectForKey:@"attributes"];
            objLink = [adicLink2 objectForKey:@"href"];
        }
        
        
        [_serviceResultsData addObject:[[GetServiceResultsObject alloc]initWithTitle:objTitle andPrice:objPrice andCategory:objCategory andArtist:objArtist andImage: (NSMutableArray *)objArrayImages  andLink:objLink]];
        _displayData = [[NSMutableArray alloc]initWithArray:_serviceResultsData];

        
    }
    //NSLog(@"This is service result %@",_serviceResultsData);
    //[self.tableView reloadData];
    
    // });
    
}

-(void)setActivityIndicator{
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.frame = CGRectMake(0.0, 0.0, 400.0, 420.0);
    _activityIndicator.center = self.view.center;
    [self.view addSubview:_activityIndicator];
    [_activityIndicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
}

-(void)startAnimatingView{
    
    //creating view in background
    
    _backGroundView = [[UIView alloc]initWithFrame:self.view.frame];
    _backGroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backGroundView];
    
    //creating bezelview
    
    _activityIndicatorView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_activityIndicatorView setBackgroundColor:[UIColor blackColor]];
    _activityIndicatorView.center = self.view.center;
    _activityIndicatorView.layer.cornerRadius = 5.f;
    
    //creating Activity Indicator
    
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicatorView addSubview:_activityIndicator];
    _activityIndicator.center = CGPointMake(_activityIndicatorView.frame.size.width/2, _activityIndicatorView.frame.size.height/2);
    [_activityIndicator startAnimating];
    [self.view addSubview:_activityIndicatorView];
    //sleep(5);
}


-(void)stopAnimatingView{
    //    [UIView animateWithDuration:0.3 animations:^{
    //        _activityIndicatorView.alpha=0.0;
    //    } completion:^(BOOL finished) {
    //        [_activityIndicator stopAnimating];
    //        //_activityIndicator.hidden = YES;
    //        //_activityIndicator.hidesWhenStopped = true;
    //    }];
    [_activityIndicator stopAnimating];
    _activityIndicatorView.alpha = 0.0;
    _backGroundView.alpha = 0.0;
    
}


-(void)maintainThreads{
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        [self startAnimatingView];
        [self getServiceData];
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        //dispatch_release(dispatchGroup);
        NSLog(@"Got request data");
        [self.tableView reloadData];
        [self stopAnimatingView];
        
    });
}




-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([searchText length] ==0) {
        [_displayData removeAllObjects];
        [_displayData addObjectsFromArray:_serviceResultsData];
    } else {
        [_displayData removeAllObjects];
        
        for (int i=0; i< _serviceResultsData.count; i++) {
            GetServiceResultsObject *searchedObject = [_serviceResultsData objectAtIndex:i];
            NSString *searchedTitle =  searchedObject.Title;
            NSRange r = [searchedTitle rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location !=NSNotFound) {
                [_displayData addObject:searchedObject];
            }
            
        }
    }
    //NSInteger count = _displayData.count;
    [_atableView reloadData];
    
    
}


//This method is to remove kepboard once we click search button
-(void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar{
    
    [_searchResultsBar resignFirstResponder];
}

 //This method is to resize my table view so that when keyboard is present the view shrinks and the cell will not be shown below the keyboard

-(void)KeyboardShown:(NSNotification*)note {
    
    CGRect KeyboardFrame;
    [[[note userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&KeyboardFrame];
    CGRect tableViewFrame = _atableView.frame;
    tableViewFrame.size.height -= KeyboardFrame.size.height;
    [_atableView setFrame:tableViewFrame];
    
}

// This method is to resize my table view so that when keyboard is removed the view goes to original size
-(void)KeyboardHidden:(NSNotification *)note{
    
    [_atableView setFrame:self.view.bounds];
}



@end

@implementation SearchBarCellClass

//-(void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar{
//    
//    [_searchResultsBar resignFirstResponder];
//}


@end
