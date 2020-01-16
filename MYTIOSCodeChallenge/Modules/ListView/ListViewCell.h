//
//  ListViewCell.h
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCellViewModel.h"
#import "MYTIOSCodeChallenge-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *typeLabel;
@property(nonatomic,weak) IBOutlet UILabel *headingLabel;
@property(nonatomic,weak) IBOutlet UILabel *coordinateLabel;

- (void)configureWith:(ListCellViewModel *)cellViewModel;
@end

NS_ASSUME_NONNULL_END
