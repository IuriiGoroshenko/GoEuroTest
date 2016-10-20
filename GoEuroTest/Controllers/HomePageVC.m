//
//  HomePageVC.m
//  GoEuroTest
//
//  Created by Yurii Goroshenko on 10/20/16.
//  Copyright © 2016 Yurii Goroshenko. All rights reserved.
//

#import "HomePageVC.h"
#import "TravelTVCell.h"
#import "HTTPManager.h"
#import "LUNSegmentedControl.h"
#import "Defines.h"

typedef enum : NSUInteger {
    TravelTabTrains,
    TravelTabBuses,
    TravelTabFlights,
    
    TravelTabCount,
} TravelTab;

@interface HomePageVC () <LUNSegmentedControlDataSource, LUNSegmentedControlDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet LUNSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (strong, nonatomic) UIRefreshControl *refreshController;
@property (assign, nonatomic) TravelTab currentTab;
@property (strong, nonatomic) NSArray *currentObjects;
@property (strong, nonatomic) NSArray *segmetTabs;

@property (strong, nonatomic) NSArray *flights;
@property (strong, nonatomic) NSArray *trains;
@property (strong, nonatomic) NSArray *buses;
#warning For fast working better change to NSMutableArray and add by 10 elemets, when scroll will at down


@end

@implementation HomePageVC

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentTab = TravelTabTrains;
    [self configureUI];
    [self refreshByTab:self.currentTab];
    
    [self loadData];
}

#pragma mark - Public

#pragma mark - Private
- (NSArray *)segmetTabs {
    if (_segmetTabs == nil) {
        _segmetTabs = @[NSLocalizedString(@"TRAINS", nil),
                        NSLocalizedString(@"BUSES", nil),
                        NSLocalizedString(@"FLIGHTS", nil)
                        ];
    }
    
    return _segmetTabs;
}

- (void)configureUI {
    [self segmentedControl:self.segmentControl didScrollWithXOffset:0];
    self.segmentControl.cornerRadius = 16.f;
    self.segmentControl.transitionStyle = LUNSegmentedControlTransitionStyleFade;
    self.segmentControl.selectorViewColor = COLOR_BLUE_LIGHT;
    
    self.navigationController.navigationBarHidden = YES;
    self.refreshController = [UIRefreshControl new];
    self.refreshController.tintColor = [UIColor grayColor];
    [self.refreshController addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshController];
}

- (void)loadData {
    [self.refreshController beginRefreshing];
    // Load flights
    [[HTTPManager sharedInstance] getTravelFlightsWithCompletion:^(NSArray *array, NSError *error) {
        self.flights = array;
        [self refreshByTab:TravelTabFlights];
    }];
    
    // Load trains
    [[HTTPManager sharedInstance] getTravelTrainsWithCompletion:^(NSArray *array, NSError *error) {
        self.trains = array;
        [self refreshByTab:TravelTabTrains];
    }];
    
    // Load buses
    [[HTTPManager sharedInstance] getTravelBusesWithCompletion:^(NSArray *array, NSError *error) {
        self.buses = array;
        [self refreshByTab:TravelTabBuses];
    }];
}

- (void)refreshByTab:(TravelTab)tab {
    switch (tab) {
        case TravelTabTrains:
            self.currentObjects = self.trains;
            break;
            
        case TravelTabBuses:
            self.currentObjects = self.buses;
            break;
            
        case TravelTabFlights:
            self.currentObjects = self.flights;
            break;
            
        default:
            self.currentObjects = self.trains;
            break;
    }
    
    if (self.currentTab == tab) {
        [self.tableView reloadData];
        [self.refreshController endRefreshing];
    }
    
    if ([self.currentObjects count] > 0) {
        self.defaultLabel.hidden = YES;
        self.tableView.hidden = NO;
    } else {
        self.defaultLabel.hidden = NO;
        self.tableView.hidden = YES;
    }
    
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currentObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier =  @"TravelTVCell";
    TravelTVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [TravelTVCell new];
    }
    
    [cell configureCellWithObject:self.currentObjects[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - SegmentedControl
- (NSArray<UIColor *> *)segmentedControl:(LUNSegmentedControl *)segmentedControl gradientColorsForStateAtIndex:(NSInteger)index {
    return @[[UIColor clearColor]];
}

- (NSInteger)numberOfStatesInSegmentedControl:(LUNSegmentedControl *)segmentedControl {
    return [self.segmetTabs count];
}

- (NSAttributedString *)segmentedControl:(LUNSegmentedControl *)segmentedControl attributedTitleForStateAtIndex:(NSInteger)index {
    return [[NSAttributedString alloc] initWithString:self.segmetTabs[index] attributes:UN_SELECTED_TEXT];
}

- (NSAttributedString *)segmentedControl:(LUNSegmentedControl *)segmentedControl attributedTitleForSelectedStateAtIndex:(NSInteger)index {
    return [[NSAttributedString alloc] initWithString:self.segmetTabs[index] attributes:SELECTED_TEXT];
}

- (void)segmentedControl:(LUNSegmentedControl *)segmentedControl didScrollWithXOffset:(CGFloat)offset {
    
}

- (void)segmentedControl:(LUNSegmentedControl *)segmentedControl didChangeStateFromStateAtIndex:(NSInteger)fromIndex toStateAtIndex:(NSInteger)toIndex {
    self.currentTab = toIndex;
    [self refreshByTab:self.currentTab];
}

@end
