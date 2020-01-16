//
//  ListViewModel.m
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import "ListViewModel.h"
#import "MYTIOSCodeChallenge-Swift.h"

@interface ListViewModel()
@property(nonatomic, strong) id<PoiDataStore> dataStore;
@property(nonatomic, strong) NSArray *pois;
@property(nonatomic, strong) NSError *error;
@end

@implementation ListViewModel

- (instancetype)initWithDataStore:(id<PoiDataStore>)dataStore {
    if (self = [super init]) {
        self.dataStore = dataStore;
        self.error = nil;
    }
    return self;
}

- (void)load {
    Coordinate *northEast = [[Coordinate alloc] initWithLatitude:53.394655 longitude:10.099891];
    Coordinate *southWest = [[Coordinate alloc] initWithLatitude:53.694865 longitude:9.757589];
    
    __block typeof(self) blocksafeSelf = self;
    
    [self.dataStore getPoisWith:northEast swPoint:southWest success:^(NSArray<POI *> * _Nullable pois) {
        blocksafeSelf.pois = pois;
        [blocksafeSelf.delegate onListViewModelReady];
    } failure:^(NSError * _Nullable error) {
        blocksafeSelf.error = error;
        [blocksafeSelf.delegate onListViewModelError:error];
    }];
}

/// Returns Number of rows based on Pois
- (NSUInteger)getNumberOfRows {
    return self.pois.count;
}

/// Returns Error
- (NSError *)getErrorReturned {
    return  self.error;
}

- (ListCellViewModel *)getListCellViewModelAt:(NSUInteger)index {
    ListCellViewModel *cellViewModel = [[ListCellViewModel alloc] initWithPOI:[self.pois objectAtIndex: index]];
    return cellViewModel;
}
@end
