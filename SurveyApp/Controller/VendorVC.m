//
//  VendorVC.m
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "VendorVC.h"
#import "VendorCell.h"

@interface VendorVC ()
{
    NSMutableArray *arrCategories, *arrIndexTitles, *arrFilteredVendors;
    NSIndexPath *oldIndexPath;
    BOOL isOther,isExpand;
    UITextField *txtOther;
    UILabel *lblOther;
}

@property (nonatomic) int currentRow;
@property (nonatomic) int currentSection;

@end

@implementation VendorVC

@synthesize tblVendors;
@synthesize searchBar;

#pragma mark - View life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigation];
    isExpand=NO;
    self.currentRow = -1;
    isOther=NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    arrCategories = [[NSMutableArray alloc] init];
    arrIndexTitles = [[NSMutableArray alloc] init];
    arrFilteredVendors = [[NSMutableArray alloc] init];
    
    tblVendors.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (IS_OS_8_OR_LATER)
        tblVendors.layoutMargins = UIEdgeInsetsZero;
    
    searchBar.showsCancelButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNavigation];
    
    arrCategories = [[[CDVendors query] all] mutableCopy];
    [arrCategories sortUsingComparator:^NSComparisonResult(CDVendors *obj1, CDVendors *obj2) {
        return [obj1.vendorName compare:obj2.vendorName];
    }];
    arrIndexTitles = [[self indexLettersForStrings:arrCategories] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - SearchBar Methods

- (void)searchBar:(UISearchBar *)searchbar textDidChange:(NSString *)searchText
{
    if (searchText.length > 0)
        [self filterContentForSearchText:searchBar.text];
    else
        arrIndexTitles = [[self indexLettersForStrings:arrCategories] mutableCopy];
    
    [tblVendors reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchbar
{
    searchBar.text = nil;
    
    [searchBar resignFirstResponder];
    
    arrIndexTitles = [[self indexLettersForStrings:arrCategories] mutableCopy];
    
    [tblVendors reloadData];
}

- (void)filterContentForSearchText:(NSString *)searchText
{
    [arrFilteredVendors removeAllObjects];
    
    arrFilteredVendors = [[arrCategories filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"vendorName contains[c] %@ OR vendorName contains[cd] %@", searchText, searchText]] mutableCopy];
    
    arrIndexTitles = [[self indexLettersForStrings:arrFilteredVendors] mutableCopy];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self filterContentForSearchText:searchController.searchBar.text];
    
    [tblVendors reloadData];
}

#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrIndexTitles count ] + 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 18.0)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, view.frame.size.width - 20.0, 18.0)];
    [label setFont:SFUITextRegular(13.0)];
    [label setTextColor:[UIColor whiteColor]];
    [view setBackgroundColor:RGB(91.0, 91.0, 91.0)];
    [view addSubview:label];
    if(section==[arrIndexTitles count])
    {
        [label setText:@"Other"];
    }
    else
    {
        [label setText:[arrIndexTitles objectAtIndex:section]];

    }
    return view;
}

- (NSArray <NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return arrIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchBar.text.length > 0 && [searchBar isFirstResponder])
    {
        NSArray *array = [[[CDVendors query] where:[NSPredicate predicateWithFormat:@"vendorName BEGINSWITH[c] %@ AND vendorName contains[c] %@" ,[arrIndexTitles objectAtIndex:section], searchBar.text]] all];
        return [array count];
    }
    else
    {
        if(section==[arrIndexTitles count])
        {
            return 1;
        }
        else
        {
            NSArray *array = [[[CDVendors query] where:[NSPredicate predicateWithFormat:@"vendorName BEGINSWITH[c] %@" ,[arrIndexTitles objectAtIndex:section]]] all];
            return [array count];
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight;
    if ([indexPath row] == self.currentRow && indexPath.section == self.currentSection)
    {
        if(isExpand==NO)
        {
            rowHeight = 44.0;
           
        }
        else
        {
            rowHeight = 88.0;
        }
    }
    else
    {
        rowHeight = 44.0f;
    }
    return rowHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"VendorCell";
    VendorCell *vendorCell = [tblVendors dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *arrCell = [[NSBundle mainBundle] loadNibNamed:@"VendorCell" owner:self options:nil];
    vendorCell = [arrCell objectAtIndex:0];
    
    
    if (searchBar.text.length > 0 && [searchBar isFirstResponder])
    {
        NSArray *array = [[[CDVendors query] where:[NSPredicate predicateWithFormat:@"vendorName BEGINSWITH[c] %@ AND vendorName contains[c] %@" ,[arrIndexTitles objectAtIndex:indexPath.section], searchBar.text]] all];
        
        CDVendors *vendor = [array objectAtIndex:indexPath.row];
        
        vendorCell.lblVendorName.text = vendor.vendorName;
        
        vendorCell.accessoryType = UITableViewCellAccessoryNone;
        
        vendorCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        if(indexPath.section==arrIndexTitles.count)
        {
                [vendorCell.lblVendorName setText:@"Other" ];
                txtOther = [[UITextField alloc] initWithFrame:CGRectMake(10, 44.0, CGRectGetWidth(self.view.frame) - 30, 30)];
                txtOther.placeholder = @"Please enter vendor name";
                txtOther.autocorrectionType = UITextAutocorrectionTypeNo;
                [txtOther setClearButtonMode:UITextFieldViewModeWhileEditing];
                txtOther.delegate=self;
            
                txtOther.layer.borderColor=[[UIColor lightGrayColor]CGColor];
                txtOther.layer.borderWidth=1.0;
                txtOther.layer.cornerRadius=3.0;
            
                UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                txtOther.leftView = paddingView;
                txtOther.leftViewMode = UITextFieldViewModeAlways;
            
                [vendorCell addSubview:txtOther];
           
            vendorCell.accessoryType = UITableViewCellAccessoryNone;
            vendorCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else
        {
            NSArray *array = [[[CDVendors query] where:[NSPredicate predicateWithFormat:@"vendorName BEGINSWITH[c] %@" ,[arrIndexTitles objectAtIndex:indexPath.section]]] all];
            
            CDVendors *vendor = [array objectAtIndex:indexPath.row];
            
           // NSLog(@"Vendor Id : %@ Vendor Name : %@",vendor.vendorId,vendor.vendorName);
            if([vendor.vendorId isEqualToString:@"974"] && [vendor.vendorName isEqualToString:@"Other"])
            {
                [vendorCell.lblVendorName setText:@"Other" ];
                txtOther = [[UITextField alloc] initWithFrame:CGRectMake(10, 44.0, CGRectGetWidth(self.view.frame) - 30, 30)];
                txtOther.placeholder = @"Please Enter Vendor Name";
                txtOther.autocorrectionType = UITextAutocorrectionTypeNo;
                [txtOther setClearButtonMode:UITextFieldViewModeWhileEditing];
                txtOther.delegate=self;
                txtOther.layer.borderColor=[[UIColor lightGrayColor]CGColor];
                txtOther.layer.borderWidth=1.0;
                txtOther.layer.cornerRadius=3.0;
                
                UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                
                txtOther.leftView = paddingView;
                txtOther.leftViewMode = UITextFieldViewModeAlways;
                
                [vendorCell addSubview:txtOther];

            }
            else
            {
                vendorCell.lblVendorName.text = vendor.vendorName;
            }
            
            vendorCell.accessoryType = UITableViewCellAccessoryNone;
            vendorCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }
    
    return vendorCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VendorCell *cell = [tblVendors cellForRowAtIndexPath:indexPath];
    
    if (oldIndexPath == nil)
    {
        oldIndexPath = indexPath;
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        VendorCell *formerSelectedcell = [tableView cellForRowAtIndexPath:oldIndexPath];
        [formerSelectedcell setAccessoryType:UITableViewCellAccessoryNone];
        
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        oldIndexPath = indexPath;
    }
    
    NSArray *array = [CoreDataAdaptor fetchVendorsFromCoreData:[NSString stringWithFormat:@"vendorName = '%@'", cell.lblVendorName.text]];
    
    CDVendors *selectedVendor = (CDVendors *)[array firstObject];
   // NSLog(@"Vendor Id Is : %@,Vendor Name %@",selectedVendor.vendorId,selectedVendor.vendorName);
    if([selectedVendor.vendorId isEqualToString:@"974"] && [selectedVendor.vendorName isEqualToString:@"Other"])
    {
        isOther=YES;
        self.currentRow = (int)indexPath.row;
        self.currentSection=(int)indexPath.section;
        
        if(isExpand==YES)
        {
            isExpand=NO;
        }
        else
        {
            isExpand=YES;
        }
        
        [self.tblVendors reloadData];
        [self.tblVendors scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    else
    {
        isOther=NO;
        [Function setStringValueToUserDefaults:selectedVendor.vendorId ForKey:kSelectedVendorID];
        [Function setStringValueToUserDefaults:selectedVendor.vendorName ForKey:kSelectedVendor];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

#pragma mark - Keyboard Notification

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    CGRect frameVendors = tblVendors.frame;
   
    frameVendors.size.height = tblVendors.frame.size.height - keyboardBounds.size.height;
    tblVendors.frame = frameVendors;

    [self tableViewScrollToBottom:YES];
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect frameVendors = tblVendors.frame;
    frameVendors.size.height = self.view.frame.size.height - tblVendors.frame.origin.y;
    tblVendors.frame = frameVendors;
    [UIView commitAnimations];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    isExpand=NO;
    return YES;
}

#pragma mark - Button Action Methods

- (IBAction)btnBack:(id)sender
{
    if(isOther)
    {
        if([txtOther.text length] > 0)
        {
            [Function setStringValueToUserDefaults:@"974" ForKey:kSelectedVendorID];
            [Function setStringValueToUserDefaults:txtOther.text ForKey:kSelectedVendor];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"Please enter other vendor name !!!"];
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Helper Methods

- (void)setupNavigation
{
    self.title = @"Select Vendor";
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnBack;
}

- (NSArray *)indexLettersForStrings:(NSArray *)strings
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableSet *set = [NSMutableSet set];
    
    for (CDVendors *vendor in strings)
    {
        if (![set containsObject:[[vendor.vendorName substringToIndex:1] lowercaseString]])
            [array addObject:[vendor.vendorName substringToIndex:1]];
        
        [set addObject:[[vendor.vendorName substringToIndex:1] lowercaseString]];
    }
    
    return [NSArray arrayWithArray:array];
}

- (void)tableViewScrollToBottom:(bool)isAnimated
{
    if (searchBar.text.length > 0 && [searchBar isFirstResponder])
    {
        if (arrFilteredVendors.count > 0)
        {
            [tblVendors scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[tblVendors numberOfRowsInSection:[tblVendors numberOfSections] -1] - 1 inSection:[tblVendors numberOfSections] - 1] atScrollPosition:UITableViewScrollPositionTop animated:isAnimated];
        }
    }
}

@end
