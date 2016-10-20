//
//  TravelTVCell.h
//  GoEuroTest
//
//  Created by Yurii Goroshenko on 10/20/16.
//  Copyright © 2016 Yurii Goroshenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDTravel;

@interface TravelTVCell : UITableViewCell

- (void)configureCellWithObject:(CDTravel *)travel;

@end

