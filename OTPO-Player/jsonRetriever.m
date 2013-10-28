/**
 * \brief Retrieve Json From server web and create an array of trackInfo Object
 *
 * \todo
 * \args One argument : The url of the Json File on the server web
 * \return to DownloadManager in order to download Data of Image and Mp3
 */

#import "jsonRetriever.h"

@interface jsonRetriever ()
@property (strong, nonatomic) NSString *urlJsonToParse;
@property (strong, nonatomic) NSMutableData *dataJson;
@property (strong, nonatomic) NSMutableArray *jsonArray;
@property (strong, nonatomic) NSMutableArray *arrayOfTrack;
@end

@implementation jsonRetriever
@synthesize urlJsonToParse = _urlJsonToParse;
@synthesize dataJson = _dataJson;
@synthesize jsonArray = _jsonArray;
@synthesize arrayOfTrack = _arrayOfTrack;

- (id)initWithUrl:(NSString*)urlJson{
    self = [super init];
    
    if (self)
    {
        _jsonArray = [[NSMutableArray alloc] init];
        _urlJsonToParse = urlJson;
        _dataJson = [[NSMutableData alloc] initWithCapacity:0];
        _arrayOfTrack = [[NSMutableArray alloc] init];
;
    }
    return self;
}

- (void)retrieveJson{
    NSURLRequest *theRequest = [NSURLRequest  requestWithURL:[NSURL URLWithString:self.urlJsonToParse]
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:60.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!connection){
        NSLog(@"Connexion to retrieve Json failed !");
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Receive Reponse for Json");
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connexion failed! %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.dataJson appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Download Finish Call of transformDataIntoObject method");
    [self transformDataIntoObject];
}

-(void)transformDataIntoObject{
    
    if(NSClassFromString(@"NSJSONSerialization")){
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:self.dataJson
                     options:0
                     error:&error];
        if(error){
            NSLog(@"Json Malformed : %@", error);
            EXIT_FAILURE;
        }
        if([object isKindOfClass:[NSArray class]]){
            for (NSArray *new in object) {
                    [self.jsonArray addObject:new];
            }
            for (int i = 0; i < [object count]; i++) {
                NSString *T1 = @"http://www.otpo.fr/uploads/";
                NSString *T2 = [self.jsonArray[i] valueForKey:@"url_img"];
                [self.arrayOfTrack addObject: [[trackInfo alloc] initWithUrlImg:[NSString stringWithFormat:@"%@%@",T1,T2] AndWith:[self.jsonArray[i] valueForKey:@"titre_new"]]];
            }
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"jsonLoaded"
             object:self];
        }
    }  
}

- (NSMutableArray*)getJson{
    return self.arrayOfTrack;
}

@end
