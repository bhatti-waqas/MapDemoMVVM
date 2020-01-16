//
//  ListViewModel.h
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListCellViewModel.h"
@class PoiDataStore;
NS_ASSUME_NONNULL_BEGIN

@protocol ListViewModelDelegate <NSObject>
- (void)onListViewModelReady;
- (void)onListViewModelError:(NSError *)error;
@end


@interface ListViewModel : NSObject
- (instancetype)initWithDataStore:(id)dataStore;
- (void)load;
- (NSUInteger)getNumberOfRows;
- (NSError *)getErrorReturned;

- (ListCellViewModel *)getListCellViewModelAt:(NSUInteger) index;
@property(nonatomic, weak) id<ListViewModelDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
