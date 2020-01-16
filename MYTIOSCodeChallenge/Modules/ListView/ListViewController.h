//
//  ListViewController.h
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 16/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UITableViewController
+ (UIViewController *)createWith:(ListViewModel *)listViewModel;
@end

NS_ASSUME_NONNULL_END
