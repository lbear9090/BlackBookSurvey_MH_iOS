//
//  VendorVC.h
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VendorVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblVendors;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end