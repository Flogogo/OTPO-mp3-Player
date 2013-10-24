//
//  downloadManager.h
//  Tableview Tutorial 3
//
//  Created by Gomis Florian on 10/21/13.
//  Copyright (c) 2013 Gomis Florian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "homeViewController.h"
#import "jsonRetriever.h"

@interface downloadManager : NSObject <NSURLConnectionDelegate>
-(id)init;
-(void)startDownload;
-(NSMutableArray*) getMyData;
@end
