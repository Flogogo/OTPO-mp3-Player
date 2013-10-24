/**
 * \brief Retrieve ImageData By using TrackInfo object which 
 *  contain all information for one Track.
 *
 *
 * \todo
 * \args No Argument when you crete the object
 * \return to homeViewController
 */

#import "downloadManager.h"


@interface downloadManager()
@property (strong, nonatomic) jsonRetriever *jsonRetriever;
@property (strong, nonatomic) NSMutableArray *arrayOfTrack;

@end

@implementation downloadManager
@synthesize arrayOfTrack = _arrayOfTrack;

-(id)init{
    self = [super init];
    if (self)
    {
        NSURLRequest *scriptUpdateJson = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.otpo.fr/index.php/News/news_control/index"]];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:scriptUpdateJson delegate:self startImmediately:YES];
        
        _arrayOfTrack = nil;
        _jsonRetriever = [[jsonRetriever alloc] initWithUrl:@"http://www.otpo.fr/Liste.json"];
        [self.jsonRetriever retrieveJson];
        // We use NSNOtification Center in order to receive signal When one picture is finish to download
        // With this we will be able to reload the view and see change on the screen.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(GetarrayOfTrack:)
                                                     name:@"jsonLoaded"
                                                   object:nil];
        
    }
    return self;
}

- (void)GetarrayOfTrack:(NSNotification *) notification{
    self.arrayOfTrack = [self.jsonRetriever getJson];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"jsonDownloaded"
     object:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //NSLog(@"Reponse recu pour : ");
    //NSLog([[[connection originalRequest] URL] absoluteString]);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connexion failed! %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //Eachtime we receive Data, we add bytes to our NSMutableArray. For this we check the url use in the connection and the url save in the NSMutableArray.
    // When they match, we just need to add the bytes to the pre existant Bytes.
    for (int i = 0; i < [self.arrayOfTrack count]; i++) {
        if ([[[connection originalRequest] URL] absoluteString] == [[self.arrayOfTrack[i] urlPicture] absoluteString])
        {
            [[self.arrayOfTrack[i] dataPicture] appendData:data];
        }
    }
}
    // When one Picture is finish we use this methods in order to send a signal to our View
    // So we can get the array with Data of picture.
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //NSLog(@"Download finish");
    
     [[NSNotificationCenter defaultCenter]
     postNotificationName:@"imageDownloaded"
     object:self];
    
    // And then close connection
    connection = nil;
}

    // With this method we create all connection that we need. We simply look in each Data of the mutable array and create request with informations
    // That we find in imageUrl.
-(void)startDownload{
        for (int i = 0; i < [self.arrayOfTrack count]; i++){
        NSURLRequest *theRequest = [NSURLRequest  requestWithURL:[self.arrayOfTrack[i] urlPicture]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                  timeoutInterval:60.0];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if (!connection){
            NSLog(@"Connexion to start download of one picture Failed !");
        }
    }
}

-(NSMutableArray*) getMyData{
    return self.arrayOfTrack;
}

@end
