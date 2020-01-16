//
//  ListViewCell.m
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (void)configureWith:(ListCellViewModel *)cellViewModel {
    self.typeLabel.text = cellViewModel.fleetType;
    self.headingLabel.text = cellViewModel.heading;
    self.coordinateLabel.text = cellViewModel.coordinatePoint;
}
@end
