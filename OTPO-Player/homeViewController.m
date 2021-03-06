//
//  TVTViewController.m
//  Tableview Tutorial 3
//
//  Created by Gomis Florian on 10/17/13.
//  Copyright (c) 2013 Gomis Florian. All rights reserved.
//

#import "homeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface homeViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) downloadManager *downloadManager;
@property (strong, nonatomic) NSMutableArray *arrayOfTrack;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@end

@implementation homeViewController
@synthesize downloadManager = _downloadManager;
@synthesize audioPlayer = _audioPlayer;


-(id) initWithCoder:(NSCoder *)aDecoder{
    
    if ((self = [super initWithCoder:aDecoder]))
    {
        
        // We create a DownloadManager which will be used to stock Data and send threw our DownloadManager.
        _downloadManager = [[downloadManager alloc] init];

        // We use NSNOtification Center in order to receive signal When one picture is finish to download
        // With this we will be able to reload the view and see change on the screen.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDataFromDownloadManager:)
                                                     name:@"imageDownloaded"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(startDownloadPicture:)
                                                     name:@"jsonDownloaded"
                                                   object:nil];
    }
    return self;
}

- (void) startDownloadPicture:(NSNotification *) notification{
    if ([[notification name] isEqualToString:@"jsonDownloaded"])
        [self.downloadManager startDownload];
}

// This method is here to receive signal from DownloadManagement and then refresh the view
- (void) receiveDataFromDownloadManager:(NSNotification *) notification
{
    self.arrayOfTrack = [self.downloadManager getMyData];
    if ([[notification name] isEqualToString:@"imageDownloaded"])
        [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTrack.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TableCellID";
    TableCell *tablecell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    tablecell.title.text = [self.arrayOfTrack[indexPath.row] titreMp3];
    [tablecell.cellImage setImage:[[UIImage alloc] initWithData:[self.arrayOfTrack[indexPath.row] dataPicture]]];
    tablecell.delegate = self;
    return tablecell;
}


// When we push delete button we remove one cell (We use delegate objet here).
- (void)deleteButtonTappedOnCell:(id)sender {
    NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
    [self.arrayOfTrack removeObjectAtIndex:indexpath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) playSong:(id)sender{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
    self.audioPlayer = [[AVPlayer alloc] initWithURL:[self.arrayOfTrack[indexpath.row] urlMp3]];
    [self.audioPlayer play];
}

- (void) stopSong:(id)sender{
    [self.audioPlayer pause];
}
@end
