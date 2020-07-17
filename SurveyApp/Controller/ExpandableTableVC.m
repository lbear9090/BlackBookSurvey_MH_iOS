//
//  ExpandableTableVC.m
//  SurveyApp
//
//  Created by C111 on 09/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "ExpandableTableVC.h"

#import "OtherCell.h"

@interface ExpandableTableVC ()
{
    NSMutableIndexSet *expandedSections;
    NSMutableArray *arrCatrgories;
    NSIndexPath *oldIndexPath;
    
    BOOL isService, isOrganization, isRole, isRating;
    BOOL isOther;
}

@end

@implementation ExpandableTableVC

@synthesize tblExpandable;

#pragma mark - View life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    
    arrCatrgories = [[NSMutableArray alloc] init];
    
    tblExpandable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (IS_OS_8_OR_LATER)
        tblExpandable.layoutMargins = UIEdgeInsetsZero;
    
    if (!expandedSections)
        expandedSections = [[NSMutableIndexSet alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNavigation];
    
    [arrCatrgories removeAllObjects];
    
    if (isService)
    {
        arrCatrgories = [[[[CDSurveyType query] where:[NSString stringWithFormat:@"parentId = %@", [NSNumber numberWithInteger:0]]] all] mutableCopy];
        
        [arrCatrgories sortUsingComparator:^NSComparisonResult(CDSurveyType * _Nonnull obj1, CDSurveyType * _Nonnull obj2) {
            return [[obj1.surveyTypeName lowercaseString] compare:[obj2.surveyTypeName lowercaseString]] == NSOrderedDescending;
        }];
    }
    else if (isRole)
    {
        arrCatrgories = [[[[CDRoles query] where:[NSString stringWithFormat:@"parentId = %@", [NSNumber numberWithInteger:0]]] all] mutableCopy];
//        [arrCatrgories sortUsingComparator:^NSComparisonResult(CDRoles * _Nonnull obj1, CDRoles * _Nonnull obj2) {
//            return [[obj1.roleName lowercaseString] compare:[obj2.roleName lowercaseString]] == NSOrderedDescending;
//        }];
    }
    else if (isOrganization)
    {
        arrCatrgories = [[[[CDOrganizationType query] where:[NSString stringWithFormat:@"parentId = %@", [NSNumber numberWithInteger:0]]] all] mutableCopy];
//        [arrCatrgories sortUsingComparator:^NSComparisonResult(CDOrganizationType * _Nonnull obj1, CDOrganizationType * _Nonnull obj2) {
//            return [[obj1.organizationTypeName lowercaseString] compare:[obj2.organizationTypeName lowercaseString]] == NSOrderedDescending;
//        }];
    }
    else if (isRating)
    {
        arrCatrgories = [[[CDRating query] all] mutableCopy];
//        [arrCatrgories sortUsingComparator:^NSComparisonResult(CDRating * _Nonnull obj1, CDRating * _Nonnull obj2) {
//            return [[obj1.ratingName lowercaseString] compare:[obj2.ratingName lowercaseString]] == NSOrderedDescending;
//        }];
      //  arrCatrgories = [[[[CDRating query] where:[NSString stringWithFormat:@"ratingId = %@",[NSNumber numberWithInteger:0]]] all] mutableCopy];
        if (arrCatrgories.count == 0) {
//            [arrCatrgories addObject:@"VENDOR OF TECHNOLOGY, PLATFORM OR SOFTWARE"];
//            [arrCatrgories addObject:@"VENDOR OF MANAGED SERVICES OR OUTSOURCED PROCESSES"];
//            [arrCatrgories addObject:@"CONSULTANT OR ADVISOR"];
        }
    }
    
    [tblExpandable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrCatrgories count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* if ([cell respondsToSelector:@selector(setSeparatorInset:)])
     [cell setSeparatorInset:UIEdgeInsetsZero]; */
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        [cell setPreservesSuperviewLayoutMargins:NO];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isOther)
    {
        static NSString *CellIdentifier = @"otherCell";
        
        OtherCell *cell = (OtherCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            
            cell = (OtherCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell.txtOther addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"categoryCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (isService)
        {
            CDSurveyType *surveyType = [arrCatrgories objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", surveyType.surveyTypeName];
            cell.separatorInset = UIEdgeInsetsMake(0.0, ([surveyType.level integerValue] * 25.0), 0.0, 0.0);
        }
        else if (isRole)
        {
            CDRoles *role = [arrCatrgories objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", role.roleName];
            cell.separatorInset = UIEdgeInsetsMake(0.0, ([role.level integerValue] * 25.0), 0.0, 0.0);
        }
        else if (isOrganization)
        {
            CDOrganizationType *organizationType = [arrCatrgories objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", organizationType.organizationTypeName];
            cell.separatorInset = UIEdgeInsetsMake(0.0, ([organizationType.level integerValue] * 25.0), 0.0, 0.0);
        }else if (isRating)
        {
//            cell.textLabel.text = [NSString stringWithFormat:@"%@", [[arrCatrgories objectAtIndex:indexPath.row]uppercaseString]];
            CDRating *rating = [arrCatrgories objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", rating.ratingName];
            cell.separatorInset = UIEdgeInsetsMake(0.0, ([rating.level integerValue] * 25.0), 0.0, 0.0);
        }
        
        if ([indexPath isEqual:oldIndexPath])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (isService)
    {
        CDSurveyType *mSurveyType = (CDSurveyType *)[arrCatrgories objectAtIndex:indexPath.row];
        
        NSArray *array = [CoreDataAdaptor fetchSurveyTypeFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", mSurveyType.surveyTypeId]];
        
        BOOL isAlreadyInserted = NO;
        [array sortedArrayUsingComparator:^NSComparisonResult(CDSurveyType *  _Nonnull obj1, CDSurveyType *  _Nonnull obj2) {
            return [obj1.surveyTypeName compare:obj2.surveyTypeName];
        }];
        for (CDSurveyType *surveyType in array)
        {
            NSInteger index = [arrCatrgories indexOfObjectIdenticalTo:surveyType];
            
            isAlreadyInserted = (index > 0 && index != NSIntegerMax);
            
            if (isAlreadyInserted)
                break;
        }
        
        if (isAlreadyInserted)
        {
            if ([array count] < 1)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getSurveyTypeName:mSurveyType] ForKey:kSelectedServices];
                [Function setStringValueToUserDefaults:mSurveyType.surveyTypeId ForKey:kSelectedServicesID];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self minimizeServices:array];
        }
        else
        {
            NSUInteger count = indexPath.row + 1;
            NSMutableArray *arCells = [NSMutableArray array];
            
            for (CDSurveyType *surveyTypes in array)
            {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [arrCatrgories insertObject:surveyTypes atIndex:count++];
            }
            
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationAutomatic];
            
            if (oldIndexPath != nil)
            {
                NSInteger row = oldIndexPath.row + [arCells count];
                oldIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
            }
            
            if ([array count] < 1)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getSurveyTypeName:mSurveyType] ForKey:kSelectedServices];
                [Function setStringValueToUserDefaults:mSurveyType.surveyTypeId ForKey:kSelectedServicesID];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self setAccessoryTypeNone];
                UITableViewCell *cell = [tblExpandable cellForRowAtIndexPath:oldIndexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    else if (isOrganization)
    {
        CDOrganizationType *mOrganizationType = (CDOrganizationType *)[arrCatrgories objectAtIndex:indexPath.row];
        
        if ([mOrganizationType.level integerValue] == 0 && [mOrganizationType.organizationTypeName containsString:@"Other"])
            isOther = YES;
        else
            isOther = NO;
        
        BOOL hasOptional = NO;
        BOOL hasChild = NO;
        BOOL hasInserted = NO;
        
        NSArray *arrChild = [CoreDataAdaptor fetchOrganizationTypeFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", mOrganizationType.organizationTypeId]];
        
        if ([arrChild count] > 0)
        {
            hasChild = YES;
            
            for (CDOrganizationType *organization in arrChild)
            {
                if ([organization.isOptional integerValue] == 1)
                {
                    hasOptional = YES;
                    break;
                }
            }
        }
        else
        {
            hasChild = NO;
        }
        
        for (CDOrganizationType *organizationType in arrChild)
        {
            NSInteger index = [arrCatrgories indexOfObjectIdenticalTo:organizationType];
            
            hasInserted = (index > 0 && index != NSIntegerMax);
            
            if (hasInserted)
                break;
        }
        
        if (hasInserted)
        {
            if ((!hasOptional && !hasChild) || hasOptional)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getOrganizationName:mOrganizationType] ForKey:kSelectedOrganizations];
                [Function setStringValueToUserDefaults:mOrganizationType.organizationTypeId ForKey:kSelectedOrganizationsID];
                
                //  [self.navigationController popViewControllerAnimated:YES];
            }
            
            [self minimizeOrganization:arrChild];
        }
        else
        {
            NSUInteger count = indexPath.row + 1;
            NSMutableArray *arCells = [NSMutableArray array];
            
            for (CDOrganizationType *organizationTypes in arrChild)
            {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [arrCatrgories insertObject:organizationTypes atIndex:count++];
            }
            
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationAutomatic];
            
            if (oldIndexPath != nil)
            {
                NSInteger row = oldIndexPath.row + [arCells count];
                oldIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
            }
            
            if ((!hasOptional && !hasChild) || hasOptional)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getOrganizationName:mOrganizationType] ForKey:kSelectedOrganizations];
                [Function setStringValueToUserDefaults:mOrganizationType.organizationTypeId ForKey:kSelectedOrganizationsID];
                
                //  [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                
                [Function setStringValueToUserDefaults:mOrganizationType.organizationTypeId ForKey:kSelectedOrganizationsID];
                [self setAccessoryTypeNone];
                
                UITableViewCell *cell = [tblExpandable cellForRowAtIndexPath:oldIndexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    else if (isRole)
    {
        CDRoles *mRole = (CDRoles *)[arrCatrgories objectAtIndex:indexPath.row];
        
        NSArray *array = [CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", mRole.roleId]];
        
        BOOL isAlreadyInserted = NO;
        
        for (CDRoles *role in array)
        {
            NSInteger index = [arrCatrgories indexOfObjectIdenticalTo:role];
            
            isAlreadyInserted = (index > 0 && index != NSIntegerMax);
            
            if (isAlreadyInserted)
                break;
        }
        
        if (isAlreadyInserted)
        {
            if ([array count] < 1)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getRoleName:mRole] ForKey:kSelectedRoles];
                [Function setStringValueToUserDefaults:mRole.roleId ForKey:kSelectedRolesID];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            [self minimizeRoles:array];
        }
        else
        {
            NSUInteger count = indexPath.row + 1;
            NSMutableArray *arCells = [NSMutableArray array];
            
            for (CDRoles *roles in array)
            {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [arrCatrgories insertObject:roles atIndex:count++];
            }
            
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationAutomatic];
            
            if (oldIndexPath != nil)
            {
                NSInteger row = oldIndexPath.row + [arCells count];
                oldIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
            }
            
            if ([array count] < 1)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getRoleName:mRole] ForKey:kSelectedRoles];
                [Function setStringValueToUserDefaults:mRole.roleId ForKey:kSelectedRolesID];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self setAccessoryTypeNone];
                
                UITableViewCell *cell = [tblExpandable cellForRowAtIndexPath:oldIndexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }else if (isRating)
    {
        if (oldIndexPath == nil)
        {
            oldIndexPath = indexPath;
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else
        {
            [self setAccessoryTypeNone];
            
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            oldIndexPath = indexPath;
        }
        
//        [Function setStringValueToUserDefaults:[NSString stringWithFormat:@"%@", [[arrCatrgories objectAtIndex:indexPath.row]uppercaseString]] ForKey:kSelectedRating];
      
        CDRating *mRating = (CDRating *)[arrCatrgories objectAtIndex:indexPath.row];
        [Function setStringValueToUserDefaults:[self getRatingName:mRating] ForKey:kSelectedRatings];
        [Function setStringValueToUserDefaults:mRating.ratingId ForKey:kSelectedRatingID];
        [self.navigationController popViewControllerAnimated:YES];
        
        /*CDRating *mRating = (CDRating *)[arrCatrgories objectAtIndex:indexPath.row];
        
        NSArray *array = [CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", mRating.ratingId]];
        
        BOOL isAlreadyInserted = NO;
        
        for (CDRating *rating in array)
        {
            NSInteger index = [arrCatrgories indexOfObjectIdenticalTo:rating];
            
            isAlreadyInserted = (index > 0 && index != NSIntegerMax);
            
            if (isAlreadyInserted)
                break;
        }
        
        if (isAlreadyInserted)
        {
            if ([array count] < 1)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getRatingName:mRating] ForKey:kSelectedRating];
                [Function setStringValueToUserDefaults:mRating.ratingId ForKey:kSelectedRating];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self minimizeRating:array];
        }
        else
        {
            NSUInteger count = indexPath.row + 1;
            NSMutableArray *arCells = [NSMutableArray array];
            
            for (CDRating *ratings in array)
            {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [arrCatrgories insertObject:ratings atIndex:count++];
            }
            
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationAutomatic];
            
            if (oldIndexPath != nil)
            {
                NSInteger row = oldIndexPath.row + [arCells count];
                oldIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
            }
            
            if ([array count] < 1)
            {
                if (oldIndexPath == nil)
                {
                    oldIndexPath = indexPath;
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
                else
                {
                    [self setAccessoryTypeNone];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    oldIndexPath = indexPath;
                }
                
                [Function setStringValueToUserDefaults:[self getRatingName:mRating] ForKey:kSelectedRating];
                [Function setStringValueToUserDefaults:mRating.ratingId ForKey:kSelectedRating];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self setAccessoryTypeNone];
                
                UITableViewCell *cell = [tblExpandable cellForRowAtIndexPath:oldIndexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }*/
    }
}

#pragma mark - UITextField Method

- (IBAction)textDidChange:(UITextField *)textfield
{
    if (isOrganization)
    {
        [Function setStringValueToUserDefaults:[NSString stringWithFormat:@"Other - %@", textfield.text] ForKey:kSelectedOrganizations];
        [Function setStringValueToUserDefaults:textfield.text ForKey:kOtherOrgaizationTitle];
    }
}

#pragma mark - Button Action Methods

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

- (void)setupNavigation
{
    if ([[Function getStringValueFromUserDefaults_ForKey:kComingFrom] isEqualToString:kComingFromService])
    {
        self.title = @"Services";
        
        isService = YES;
        isOrganization = NO;
        isRole = NO;
        isRating = NO;
    }
    else if ([[Function getStringValueFromUserDefaults_ForKey:kComingFrom] isEqualToString:kComingFromOrganization])
    {
        self.title = @"Organizations";
        
        isService = NO;
        isOrganization = YES;
        isRole = NO;
        isRating = NO;
    }
    else if ([[Function getStringValueFromUserDefaults_ForKey:kComingFrom] isEqualToString:kComingFromRole])
    {
        self.title = @"Roles";
        
        isService = NO;
        isOrganization = NO;
        isRole = YES;
        isRating = NO;
    }
    else if ([[Function getStringValueFromUserDefaults_ForKey:kComingFrom] isEqualToString:kComingFromRting])
    {
        self.title = @"Rating";
        isService = NO;
        isOrganization = NO;
        isRole = NO;
        isRating = YES;
    }

    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnBack;
}

- (void)minimizeRating:(NSArray *)arrMinimize
{
    for (CDRating *rating in arrMinimize)
    {
        NSUInteger indexToRemove = [arrCatrgories indexOfObjectIdenticalTo:rating];
        
        NSArray *array = [CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", rating.ratingId]];
        
        if (array && [array count] > 0)
        {
            [self minimizeRoles:array];
        }
        
        if ([arrCatrgories indexOfObjectIdenticalTo:rating] != NSNotFound)
        {
            [arrCatrgories removeObjectIdenticalTo:rating];
            [tblExpandable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}
- (void)minimizeRoles:(NSArray *)arrMinimize
{
    for (CDRoles *role in arrMinimize)
    {
        NSUInteger indexToRemove = [arrCatrgories indexOfObjectIdenticalTo:role];
        
        NSArray *array = [CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", role.roleId]];
        
        if (array && [array count] > 0)
        {
            [self minimizeRoles:array];
        }
        
        if ([arrCatrgories indexOfObjectIdenticalTo:role] != NSNotFound)
        {
            [arrCatrgories removeObjectIdenticalTo:role];
            [tblExpandable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)minimizeServices:(NSArray *)arrMinimize
{
    for (CDSurveyType *surveyType in arrMinimize)
    {
        NSUInteger indexToRemove = [arrCatrgories indexOfObjectIdenticalTo:surveyType];
        
        NSArray *array = [CoreDataAdaptor fetchSurveyTypeFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", surveyType.surveyTypeId]];
        
        if (array && [array count] > 0)
        {
            [self minimizeServices:array];
        }
        
        if ([arrCatrgories indexOfObjectIdenticalTo:surveyType] != NSNotFound)
        {
            [arrCatrgories removeObjectIdenticalTo:surveyType];
            [tblExpandable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)minimizeOrganization:(NSArray *)arrMinimize
{
    for (CDOrganizationType *organizationType in arrMinimize)
    {
        NSUInteger indexToRemove = [arrCatrgories indexOfObjectIdenticalTo:organizationType];
        
        NSArray *array = [CoreDataAdaptor fetchOrganizationTypeFromCoreData:[NSString stringWithFormat:@"parentId = '%@'", organizationType.organizationTypeId]];
        
        if (array && [array count] > 0)
        {
            [self minimizeOrganization:array];
        }
        
        if ([arrCatrgories indexOfObjectIdenticalTo:organizationType] != NSNotFound)
        {
            [arrCatrgories removeObjectIdenticalTo:organizationType];
            [tblExpandable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (NSString *)getOrganizationName:(CDOrganizationType *)organizationType
{
    CDOrganizationType *organization = organizationType;
    NSString *strOrganizationName = nil;
    NSMutableArray *arrStrings = [[NSMutableArray alloc] init];
    
    while ([organization.parentId integerValue] != 0)
    {
        CDOrganizationType *aOrganizationtype = (CDOrganizationType *)[[CoreDataAdaptor fetchOrganizationTypeFromCoreData:[NSString stringWithFormat:@"organizationTypeId = '%@'", organization.parentId]] firstObject];
        [arrStrings addObject:aOrganizationtype.organizationTypeName];
        
        if ([aOrganizationtype.parentId integerValue] != 0)
            organization = aOrganizationtype;
        else
            break;
    }
    
    [arrStrings insertObject:organizationType.organizationTypeName atIndex:0];
    
    if ([arrStrings count] > 0)
    {
        for (int i = [arrStrings count]; i > 0; i--)
        {
            if (strOrganizationName.length < 1)
                strOrganizationName = [arrStrings objectAtIndex:i - 1];
            else
                strOrganizationName = [NSString stringWithFormat:@"%@ - %@", strOrganizationName, [arrStrings objectAtIndex:i - 1]];
        }
    }
    
    return strOrganizationName;
}

- (NSString *)getRoleName:(CDRoles *)roles
{
    CDRoles *role = roles;
    NSString *strRoleName = nil;
    NSMutableArray *arrStrings = [[NSMutableArray alloc] init];
    
    while ([role.parentId integerValue] != 0)
    {
        CDRoles *aRole = (CDRoles *)[[CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"roleId = '%@'", role.parentId]] firstObject];
        [arrStrings addObject:aRole.roleName];
        
        if ([aRole.parentId integerValue] != 0)
            role = aRole;
        else
            break;
    }
    
    [arrStrings insertObject:roles.roleName atIndex:0];
    
    if ([arrStrings count] > 0)
    {
        for (int i = [arrStrings count]; i > 0; i--)
        {
            if (strRoleName.length < 1)
                strRoleName = [arrStrings objectAtIndex:i - 1];
            else
                strRoleName = [NSString stringWithFormat:@"%@ - %@", strRoleName, [arrStrings objectAtIndex:i - 1]];
        }
    }
    
    return strRoleName;
}
- (NSString *)getRatingName:(CDRating *)rating
{
    CDRating *ratings = rating;
    NSString *strRatingName = nil;
    NSMutableArray *arrStrings = [[NSMutableArray alloc] init];
    
    while ([ratings.parentId integerValue] != 0)
    {
        CDRating *aRating = (CDRating *)[[CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"ratingId = '%@'", ratings.parentId]] firstObject];
        [arrStrings addObject:aRating.ratingName];
        
        if ([aRating.parentId integerValue] != 0)
            ratings = aRating;
        else
            break;
    }
    
    [arrStrings insertObject:ratings.ratingName atIndex:0];
    
    if ([arrStrings count] > 0)
    {
        for (int i = [arrStrings count]; i > 0; i--)
        {
            if (strRatingName.length < 1)
                strRatingName = [arrStrings objectAtIndex:i - 1];
            else
                strRatingName = [NSString stringWithFormat:@"%@ - %@", strRatingName, [arrStrings objectAtIndex:i - 1]];
        }
    }
    
    return strRatingName;
}
- (NSString *)getSurveyTypeName:(CDSurveyType *)surveyTypes
{
    CDSurveyType *surveyType = surveyTypes;
    NSString *strSurveyType = nil;
    NSMutableArray *arrStrings = [[NSMutableArray alloc] init];
    
    while ([surveyType.parentId integerValue] != 0)
    {
        CDSurveyType *aSurveyType = (CDSurveyType *)[[CoreDataAdaptor fetchSurveyTypeFromCoreData:[NSString stringWithFormat:@"surveyTypeId = '%@'", surveyType.parentId]] firstObject];
        [arrStrings addObject:aSurveyType.surveyTypeName];
        
        if ([aSurveyType.parentId integerValue] != 0)
            surveyType = aSurveyType;
        else
            break;
    }
    
    [arrStrings insertObject:surveyTypes.surveyTypeName atIndex:0];
    
    if ([arrStrings count] > 0)
    {
        for (int i = [arrStrings count]; i > 0; i--)
        {
            if (strSurveyType.length < 1)
                strSurveyType = [arrStrings objectAtIndex:i - 1];
            else
                strSurveyType = [NSString stringWithFormat:@"%@ - %@", strSurveyType, [arrStrings objectAtIndex:i - 1]];
        }
    }
    
    return strSurveyType;
}

- (void)setAccessoryTypeNone
{
    for (NSInteger j = 0; j < [tblExpandable numberOfSections]; ++j)
    {
        for (NSInteger i = 0; i < [tblExpandable numberOfRowsInSection:j]; ++i)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:j];
            UITableViewCell *cell = [tblExpandable cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

@end
