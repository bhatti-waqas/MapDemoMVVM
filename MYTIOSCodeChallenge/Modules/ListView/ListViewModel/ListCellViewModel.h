//
//  ListCellViewModel.h
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MYTIOSCodeChallenge-Swift.h"
@class POI;
NS_ASSUME_NONNULL_BEGIN

@interface ListCellViewModel : NSObject
- (instancetype)initWithPOI:(POI *)poi;

@property(nonatomic, readonly) NSString *fleetType;
@property(nonatomic, readonly) NSString *heading;
@property(nonatomic, readonly) NSString *coordinatePoint;
@end

NS_ASSUME_NONNULL_END
