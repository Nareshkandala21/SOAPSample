//
//  ViewController.m
//  SoapSample
//
//  Created by Naresh Kandala on 24/12/16.
//  Copyright © 2016 Naresh Kandala. All rights reserved.
//

#import "ViewController.h"
#import "AppHelper.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "XMLReader.h"
#import "DBManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginService];
    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark Login Service
//-(void)loginService
//{
////    AppDelegate*appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//    if([AppHelper appDelegate].checkNetworkReachability)
//    {
//        [[AppHelper sharedInstance]showIndicator];
//
//        NSString* soapMessage = [NSString stringWithFormat:	@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//                                 "<soap:Body>\n"
//                                 "<getUserLoginDetails xmlns=\"http://service.com\">\n"
//                                 "<loginId>%@</loginId>\n"
//                                 "<mobileType>%@</mobileType>\n"
//                                 "<registration_id>%@</registration_id>\n"
//                                 "<smeid>%@</smeid>\n"
//                                 "</getUserLoginDetails>\n"
//                                 "</soap:Body>\n"
//                                 "</soap:Envelope>\n",@"",@"4",@"",@""];
//        
//        
//        
//        NSLog(@"dfsdfsd%@",soapMessage);
//        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
////        NSURL *url = [NSURL URLWithString:BaseUrl];
//        NSURL *url = [NSURL URLWithString:@"http://115.111.141.49:8082/Enterpise_MIS_WS/services/Enterpirse_MIS_WS?wsdl"];
//
//        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url] ;
//        //	NSLog(@"%i",[theRequest retainCount]); retain count is 1, but we are not the owner of object
//        
//        [theRequest addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
//        [theRequest addValue: @"getUserLoginDetails" forHTTPHeaderField:@"SOAPAction"];  //Note Api specific line
//        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//        [theRequest setHTTPMethod:@"POST"];
//        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//        
//        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
//        
//        
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSError *error;
//            //            [[AppHelper sharedInstance]hideIndicator];
//            
//            //parse NSXMLParser object here if request successfull
//            if ([responseObject isKindOfClass:[NSXMLParser class]]) {
//                NSXMLParser *parser = (NSXMLParser *)responseObject;
//                NSDictionary *dict = [XMLReader dictionaryForNSXMLParser:parser error:&error];
//                NSString *strMain=[[[[[dict objectForKey:@"soapenv:Envelope"] objectForKey:@"soapenv:Body"] objectForKey:@"ns:getUserLoginDetailsResponse"] objectForKey:@"ns:return"] objectForKey:@"text"];
//                NSString *vaildS=[[strMain componentsSeparatedByString:@","] objectAtIndex:0];
//                
//                if(strMain)
//                {
//                    
//                    NSLog(@"login response%@",strMain);
//                    
//                }
//                
//                
//                
//                
//                
//            }
//            else{
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [[AppHelper sharedInstance]hideIndicator];
//            
//            //NSLog(@"Error: %@", error);
//        }];
//        
//        
//        [[NSOperationQueue mainQueue] addOperation:operation];
//    }
//    else{
//        
//        DBManager *  db = [[DBManager alloc]init];
//        BOOL checkdata=[db check_isdataAvailable];
//        
//        if (checkdata==YES) {
//            NSLog(@"data_isavailable");
//              //      [self gettingDataService];
//            //call data from db
//            
//        }else{
//            
//            //call service
//            
//            //  [self BioDataService];
//        }
//        
//
//        
//        
//        
//    }
//    
//}


-(void)callingRestByAFNetworking
{
    
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://samwize.com/"]];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
//                                                            path:@"http://samwize.com/api/pigs/"
//                                                      parameters:nil];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // Print the response body in text
//        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [operation start];
    
    
    
}


-(void)anotherWay
{
    
    //Init the NSURLSession with a configuration
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //Create an URLRequest
    NSURL *url = [NSURL URLWithString:@"yourURL"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    //Create POST Params and add it to HTTPBody
    NSString *params = @"api_key=APIKEY&email=example@example.com&password=password";
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Create task
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //Handle your response here
    }];
    
    [dataTask resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
