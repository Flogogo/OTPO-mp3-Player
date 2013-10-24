//
//  trackInfo.m
//  Tableview Tutorial 3
//
//  Created by Gomis Florian on 10/22/13.
//  Copyright (c) 2013 Gomis Florian. All rights reserved.
//

#import "trackInfo.h"
@interface trackInfo ()

@end

@implementation trackInfo
@synthesize urlMp3 = _urlMp3;
@synthesize urlPicture = _urlPicture;
@synthesize titreMp3 = _titreMp3;
@synthesize dataMp3 = _dataMp3;
@synthesize dataPicture = _dataPicture;

-(id) initWithUrlImg:(NSString*)urlImg AndWith:(NSString*)titleSong{
    self = [super init];
    if (self)
    {
        _dataPicture = [[NSMutableData alloc] initWithCapacity:0];
        _dataMp3 = [[NSMutableData alloc] initWithCapacity:0];
        _urlPicture = urlImg;
        _urlMp3 = @"";
        _titreMp3 = titleSong;
    }
    return self;
}



@end
