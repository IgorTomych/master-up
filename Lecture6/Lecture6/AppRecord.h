@interface AppRecord : NSObject
{
    NSString *appName;
    UIImage *appIcon;
    NSString *artist;
    NSString *imageURLString;
    NSString *appURLString;
}

@property (nonatomic, retain) NSString *appName;
@property (nonatomic, retain) UIImage *appIcon;
@property (nonatomic, retain) NSString *artist;
@property (nonatomic, retain) NSString *imageURLString;
@property (nonatomic, retain) NSString *appURLString;

@end