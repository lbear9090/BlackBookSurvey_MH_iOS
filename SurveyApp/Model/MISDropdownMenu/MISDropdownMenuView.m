//
//  MISDropdownMenuView.m
//  MISDropdownViewController
//
//  Created by Michael Schneider on 4/11/15.
//  Copyright (c) 2015 mischneider. All rights reserved.
//

#import "MISDropdownMenuView.h"

static NSString *MISDropdownMenuViewCellIdentifier = @"MISDropdownMenuViewCellIdentifier";

@interface MISDropdownMenuView () <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic, readwrite) NSArray *items;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MISDropdownMenuView

#pragma mark - Lifecycle

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super initWithFrame:CGRectZero];
    if (self == nil) { return self; }
    
    _items = [items copy];
    _selectedItemIndex = 0;

    self.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    
    return self;
}

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44.0;
    
    [self addSubview:tableView];
    
    // Remove separators after the last row
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.frame), 2.0)];
    
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:MISDropdownMenuViewCellIdentifier];
    
    _tableView = tableView;
    [_tableView reloadData];
}

#pragma mark - Setter / Getter

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    _selectedItemIndex = selectedItemIndex;
    [self.tableView reloadData];
}


#pragma mark - UIView

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat tableViewHeight = self.items.count * self.tableView.rowHeight;
    return CGSizeMake(size.width, tableViewHeight);
}


#pragma mark - UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BOOL isRowSelected = (indexPath.row == self.selectedItemIndex);
    NSString *item = self.items[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MISDropdownMenuViewCellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0)
        cell.backgroundColor = RGB(242.0, 242.0, 242.0);
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = item;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = SFUITextBold(15.0);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove insets in UITableViewCell separator
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        cell.preservesSuperviewLayoutMargins = NO;
    }
    
    // Explictly set cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"called %li",(long)indexPath.row);
    
    self.selectedItemIndex = indexPath.row;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


@end
