//
//  TVTViewController.h
//  Tableview Tutorial 3
//
//  Created by Gomis Florian on 10/17/13.
//  Copyright (c) 2013 Gomis Florian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCell.h"
#import "downloadManager.h"
#import "trackInfo.h"

@interface homeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TableCellDelegate, NSURLConnectionDelegate>

@end
