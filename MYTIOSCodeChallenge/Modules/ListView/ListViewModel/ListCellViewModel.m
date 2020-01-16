//
//  ListCellViewModel.m
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import "ListCellViewModel.h"
#import "MYTIOSCodeChallenge-Swift.h"
@implementation ListCellViewModel

- (instancetype)initWithPOI:(POI *)poi {
    if (self = [super init]) {
        _fleetType = [poi.fleetType isEqualToString:@""] ? @"No Type Found" : poi.fleetType;
        _heading = [NSString stringWithFormat:@"Heading: %f",poi.heading];
        _coordinatePoint = [NSString stringWithFormat:@"Latitude: %f, Longitude: %f",poi.coordinate.latitude,poi.coordinate.longitude];
    }
    return self;
}

@end
