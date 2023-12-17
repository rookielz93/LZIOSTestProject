//
//  LZITPHomeViewController.m
//  LZIOSTestProject
//
//  Created by jinshengli on 12/17/2023.
//  Copyright (c) 2023 jinshengli. All rights reserved.
//

#import "LZITPHomeViewController.h"
#import "LZPageModel.h"
#import "LZITPTestPage.h"

#define kCellId @"kCellId"

@interface LZITPHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <LZPageModel *>*dataSource;

@end

@implementation LZITPHomeViewController

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)dataInit {
    [super dataInit];
    
    NSArray *idens = @[ NSStringFromClass(LZITPTestPage.class) ];
    NSArray *titles = idens;
    for (int i=0; i<titles.count; i++) {
        LZPageModel *m = [LZPageModel new];
        m.title = titles[i];
        m.iden = idens[i];
        [self.dataSource addObject:m];
    }
}

- (void)uiInit {
    [super uiInit];
    
    self.title = @"Home";
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellId];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
}

// MARK: - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZPageModel *m = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = m.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LZPageModel *m = self.dataSource[indexPath.row];
    [self performSegueWithIdentifier:m.iden sender:nil];
}

// MARK: - Props

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
