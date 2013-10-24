//
//  trackInfo.h
//  Tableview Tutorial 3
//
//  Created by Gomis Florian on 10/22/13.
//  Copyright (c) 2013 Gomis Florian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface trackInfo : NSObject
-(id) initWithUrlImg:(NSString*)urlImg AndWith:(NSString*)titleSong;
@property (strong, nonatomic) NSString *titreMp3;
@property (strong, nonatomic) NSString *urlPicture;
@property (strong, nonatomic) NSString *urlMp3;
@property (strong, nonatomic) NSMutableData *dataPicture;
@property (strong, nonatomic) NSMutableData *dataMp3;
@end
