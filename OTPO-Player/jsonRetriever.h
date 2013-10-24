//
//  jsonRetriever.h
//  OTPO-Player
//
//  Created by Gomis Florian on 10/23/13.
//  Copyright (c) 2013 Gomis Florian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "trackInfo.h"

@interface jsonRetriever : NSObject <NSURLConnectionDelegate>
- (id)initWithUrl:(NSString*)urlJson;
- (void)retrieveJson;
- (NSMutableArray*)getJson;
@end
