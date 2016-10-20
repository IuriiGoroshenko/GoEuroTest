//
//  TravelTVCell.m
//  GoEuroTest
//
//  Created by Yurii Goroshenko on 10/20/16.
//  Copyright © 2016 Yurii Goroshenko. All rights reserved.
//

#import "TravelTVCell.h"
#import "CDTravel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TravelTVCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroungLogoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@end

@implementation TravelTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellWithObject:(CDTravel *)travel {

#warning Better have some placeholderImage
    [self.backgroungLogoImageView setImageWithURL:[NSURL URLWithString:travel.logoURL]
                       placeholderImage:nil];
    
    [self.logoImageView setImageWithURL:[NSURL URLWithString:travel.logoURL]
                       placeholderImage:nil];
    
    self.priceLabel.text = [NSString stringWithFormat:@"€ %@", travel.price];
    NSString *stringFormat = [travel.numberOfChanges integerValue] == 0 ? @"%@ - %@" : @"%@ - %@ (+%@)";
    
    self.timeLabel.text = [NSString stringWithFormat:stringFormat, travel.arrivalTime, travel.departureTime, travel.numberOfChanges];
    self.durationLabel.text = [NSString stringWithFormat:@"Duration Time: %@", travel.duration];
}

@end
