//
//  DBManager.m
//  Laqshya
//
//  Created by Vikas Lov on 5/1/15.
//  Copyright (c) 2015 Vikas Lov. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "Defines.h"
#import "AppHelper.h"
#import "AFNetworking.h"
#import "XMLReader.h"
#import "MBProgressHUD.h"
#import "AppHelper.h"
#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
#import "SSKeychain.h"
#import <AdSupport/AdSupport.h>
#import "ViewController.h"

@implementation DBManager


//-(void)gettingDataService
//{
//    
//    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
//     [database open];
//
//    
//    if([AppHelper appDelegate].checkNetworkReachability)
//    {
//       [[AppHelper sharedInstance]showIndicator];
//        
//        AppDelegate*appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//
//        NSArray *subStrings = [[NSString stringWithFormat:@"%@",[ASIdentifierManager sharedManager].advertisingIdentifier] componentsSeparatedByString:@" "];
//        
//        
//        KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KeychainTest" accessGroup:nil];
//        
//        appdelegate.MobileToken=[keychain objectForKey:(id)kSecAttrAccount];
//        
//        
//        appdelegate.MobileToken=@"123456789";
//        subStrings =[NSArray arrayWithObjects:@"123445",@"0",@"2A277EDD-5F6F-490C-893F-3062C0197126" ,nil];
//        
//
//     NSString *soapMessage = [NSString stringWithFormat:	@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//                       "<soap:Body>\n"
//                       "<getJsonDataDetailById xmlns=\"http://service.com\">\n"
//                       "<loginId>%@</loginId>\n"
//                       "<registration_id>%@</registration_id>\n"
//                       "<smeid>%@</smeid>\n"
//                       "</getJsonDataDetailById>\n"
//                       "</soap:Body>\n"
//                       "</soap:Envelope>\n",@"",appdelegate.MobileToken,[subStrings objectAtIndex:2]];;
//
//        
//        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
//        NSURL *url = [NSURL URLWithString:BaseUrl];
//        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url] ;
//        
//        //	NSLog(@"%i",[theRequest retainCount]); retain count is 1, but we are not the owner of object
//        
//        [theRequest addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
//        [theRequest addValue: @"getJsonDataDetailById" forHTTPHeaderField:@"SOAPAction"];  //Note Api specific line
//        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//        [theRequest setHTTPMethod:@"POST"];
//        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//        
//        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
//        
//        
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSError *error;
//            [[AppHelper sharedInstance]hideIndicator];
//            //parse NSXMLParser object here if request successfull
//            if ([responseObject isKindOfClass:[NSXMLParser class]]) {
//                NSXMLParser *parser = (NSXMLParser *)responseObject;
//                NSDictionary *dict = [XMLReader dictionaryForNSXMLParser:parser error:&error];
//                NSString *strMain=[[[[[dict objectForKey:@"soapenv:Envelope"] objectForKey:@"soapenv:Body"] objectForKey:@"ns:getJsonDataDetailByIdResponse"] objectForKey:@"ns:return"] objectForKey:@"text"];
//                if(strMain){
//                    NSData *data = [strMain dataUsingEncoding:NSUTF8StringEncoding];
//                    NSDictionary *jsonD = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                    NSLog(@"json%@",jsonD);
//                    
//                    
////                     NSDictionary *jsonDashBoard =[jsonD objectForKey:@"DASHBOARD_DATA"];
////                    NSDictionary *jsonDashBoard_Details =[jsonD objectForKey:@"DASHBOARD_DETAIL_DATA"];
//                    
//                    
//                    NSArray *arr_OPEX_BGT_Details =[jsonD objectForKey:@"DETAIL_OPEX_BGT"];
//                    NSArray *arr_MANNING_BGT_Details =[jsonD objectForKey:@"DETAIL_MANNING_BGT"];
//                    NSArray *arr_DOWNTIME_TANKER_Details =[jsonD objectForKey:@"DETAIL_DOWNTIME_TANKER"];
//                    NSArray *arr_DOWNTIME_BULKER_Details =[jsonD objectForKey:@"DETAIL_DOWNTIME_BULKER"];
//
//                    
//                    
//
//                    NSArray *arr_OPEX_BGT =[jsonD objectForKey:@"GRAF_OPEX_BGT"];
//                    NSArray *arr_MANNING_BGT =[jsonD objectForKey:@"GRAF_MANNING_BGT"];
//                    NSArray *arr_DOWNTIME_TANKER =[jsonD objectForKey:@"GRAF_DOWNTIME_TANKER"];
//                    NSArray *arr_DOWNTIME_BULKER =[jsonD objectForKey:@"GRAF_DOWNTIME_BULKER"];
//                    NSArray *arr_PROJ_ACTUALS =[jsonD objectForKey:@"GRAF_PRO_ACTUALS"];
//                    NSArray *arr_TCY =[jsonD objectForKey:@"GRAF_TCY"];
//                    NSArray *arr_TCYTREND =[jsonD objectForKey:@"GRAF_TCYTREND"];
//
//             
//          //OPEX_BGT
//                for (int i = 0; i<[arr_OPEX_BGT count]; i++) {
//
//                    NSString *str_ACTUALS_INR=[[arr_OPEX_BGT objectAtIndex:i] objectForKey:@"ACTUALS_INR"];
//                    NSString *str_BUDG_INR=[[arr_OPEX_BGT objectAtIndex:i] objectForKey:@"BUDG_INR"];
//                    NSString *str_FINYEAR=[[arr_OPEX_BGT objectAtIndex:i] objectForKey:@"FINYEAR"];
//                    NSString *str_SHIP_TYPE=[[arr_OPEX_BGT objectAtIndex:i] objectForKey:@"SHIP_TYPE"];
//                    
//                    
//                    
//               NSString *insertQuery_insert_Opex_bud = [NSString stringWithFormat:@" INSERT INTO OPEX_BGT1 ( ACTUALS_INR, BUDG_INR, FINYEAR,SHIP_TYPE ) VALUES ('%@', '%@', '%@', '%@' )",str_ACTUALS_INR,str_BUDG_INR,str_FINYEAR,str_SHIP_TYPE];
//                    
//                    [database executeUpdate:insertQuery_insert_Opex_bud];
//
//                }
//                 
//          //MANNING_BGT
//               
//                    for (int i = 0; i<[arr_MANNING_BGT count]; i++) {
//                        
//                        NSString *str_ACTUALS_INR=[[arr_MANNING_BGT objectAtIndex:i] objectForKey:@"ACTUALS_INR"];;
//                        NSString *str_BUDG_INR=[[arr_MANNING_BGT objectAtIndex:i] objectForKey:@"BUDG_INR"];
//                        NSString *str_FINYEAR=[[arr_MANNING_BGT objectAtIndex:i] objectForKey:@"FINYEAR"];
//                        NSString *str_SHIP_TYPE=[[arr_MANNING_BGT objectAtIndex:i] objectForKey:@"SHIP_TYPE"];
//                        
//                        
//                        
//                        NSString *insertQuery_insert_MANNING_BGT = [NSString stringWithFormat:@" INSERT INTO MANNING_BGT1 ( ACTUALS_INR, BUDG_INR, FINYEAR, SHIP_TYPE ) VALUES ('%@', '%@', '%@', '%@' )",str_ACTUALS_INR,str_BUDG_INR,str_FINYEAR,str_SHIP_TYPE];
//                        
//                        [database executeUpdate:insertQuery_insert_MANNING_BGT];
//                        
//                    }
//                    
//        //DOWNTIME_TANKER
//                    for (int i = 0; i<[arr_DOWNTIME_TANKER count]; i++) {
//                        
//                        NSString *str_CATEGORY=[[arr_DOWNTIME_TANKER objectAtIndex:i] objectForKey:@"CATEGORY"];
//                        NSString *str_DOWNTIME_TYPE=[[arr_DOWNTIME_TANKER objectAtIndex:i] objectForKey:@"DOWNTIME_TYPE"];
//                        NSString *str_DWT_USD=[[arr_DOWNTIME_TANKER objectAtIndex:i] objectForKey:@"DWT_USD"];
//                        NSString *str_SHIP_TYPE=[[arr_DOWNTIME_TANKER objectAtIndex:i] objectForKey:@"SHIP_TYPE"];
//                        
//                        
//                        NSString *insertQuery_insert_DOWNTIME_TANKER = [NSString stringWithFormat:@" INSERT INTO DOWNTIME_TANKER1 ( CATEGORY, DOWNTIME_TYPE, DWT_USD, SHIP_TYPE ) VALUES ('%@', '%@', '%@', '%@' )",str_CATEGORY,str_DOWNTIME_TYPE,str_DWT_USD,str_SHIP_TYPE];
//                        
//                        [database executeUpdate:insertQuery_insert_DOWNTIME_TANKER];
//                        
//                    }
//                    
//        //DOWNTIME_Bulker
//                    
//                    for (int i = 0; i<[arr_DOWNTIME_BULKER count]; i++) {
//                        
//                        NSString *str_CATEGORY=[[arr_DOWNTIME_BULKER objectAtIndex:i] objectForKey:@"CATEGORY"];
//                        NSString *str_DOWNTIME_TYPE=[[arr_DOWNTIME_BULKER objectAtIndex:i] objectForKey:@"DOWNTIME_TYPE"];
//                        NSString *str_DWT_USD=[[arr_DOWNTIME_BULKER objectAtIndex:i] objectForKey:@"DWT_USD"];
//                        NSString *str_SHIP_TYPE=[[arr_DOWNTIME_BULKER objectAtIndex:i] objectForKey:@"SHIP_TYPE"];
//                        
//                        
//                        NSString *insertQuery_insert_DOWNTIME_Bulker = [NSString stringWithFormat:@" INSERT INTO DOWNTIME_BULKER1 (CATEGORY,DOWNTIME_TYPE,DWT_USD,SHIP_TYPE) VALUES ('%@', '%@', '%@', '%@' )",str_CATEGORY,str_DOWNTIME_TYPE,str_DWT_USD,str_SHIP_TYPE];
//                        
//                        [database executeUpdate:insertQuery_insert_DOWNTIME_Bulker];
//                        
//                    }
//
//                    
//           //PROJ_ACTUALS
//                    for (int i = 0; i<[arr_PROJ_ACTUALS count]; i++) {
//                        
//                        NSString *str_FY_ACT_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"FY_ACT_AMT"];
//                        NSString *str_FY_PROJ_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"FY_PROJ_AMT"];
//                        
//                        NSString *str_Q1_ACT_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q1_ACT_AMT"];
//                        NSString *str_Q1_PROJ_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q1_PROJ_AMT"];
//                        
//                        NSString *str_Q2_ACT_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q2_ACT_AMT"];
//                        NSString *str_Q2_PROJ_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q2_PROJ_AMT"];
//                        
//                        NSString *str_Q3_ACT_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q3_ACT_AMT"];
//                        NSString *str_Q3_PROJ_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q3_PROJ_AMT"];
//                        
//                        NSString *str_Q4_ACT_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q4_ACT_AMT"];
//                        NSString *str_Q4_PROJ_AMT=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"Q4_PROJ_AMT"];
//                        
//                        NSString *str_SHIP_TYPE_CD=[[arr_PROJ_ACTUALS objectAtIndex:i] objectForKey:@"SHIP_TYPE_CD"];
//
//
//                        
//                        NSString *insertQuery_insert_PROJ_ACTUALS = [NSString stringWithFormat:@"INSERT INTO PROJ_ACTUALS1  (  FY_ACT_AMT,  FY_PROJ_AMT,  Q1_ACT_AMT,  Q1_PROJ_AMT, Q2_ACT_AMT,  Q2_PROJ_AMT, Q3_ACT_AMT,  Q3_PROJ_AMT, Q4_ACT_AMT,  Q4_PROJ_AMT, SHIP_TYPE_CD  ) VALUES ('%@', '%@', '%@', '%@','%@', '%@', '%@', '%@','%@', '%@', '%@' )",str_FY_ACT_AMT,str_FY_PROJ_AMT,str_Q1_ACT_AMT,str_Q1_PROJ_AMT,str_Q2_ACT_AMT,str_Q2_PROJ_AMT,str_Q3_ACT_AMT,str_Q3_PROJ_AMT,str_Q4_ACT_AMT,str_Q4_PROJ_AMT,str_SHIP_TYPE_CD];
//                        
//                        [database executeUpdate:insertQuery_insert_PROJ_ACTUALS];
//                        
//                    }
//
//             //TCY
//                    
//                    for (int i = 0; i<[arr_TCY count]; i++) {
//                        
//                        NSString *str_SHIP_SUBTYPE_NAME=[[arr_TCY objectAtIndex:i] objectForKey:@"SHIP_SUBTYPE_NAME"];
//                        NSString *str_SHIP_TYPE_NAME=[[arr_TCY objectAtIndex:i] objectForKey:@"SHIP_TYPE_NAME"];
//                        NSString *str_TCY_ACT_AMT=[[arr_TCY objectAtIndex:i] objectForKey:@"TCY_ACT_AMT"];
//
//                        
//                        
//                        NSString *insertQuery_insert_TYC = [NSString stringWithFormat:@" INSERT INTO TCY1 (SHIP_SUBTYPE_NAME, SHIP_TYPE_NAME, TCY_ACT_AMT ) VALUES ('%@', '%@', '%@' )",str_SHIP_SUBTYPE_NAME,str_SHIP_TYPE_NAME,str_TCY_ACT_AMT];
//                        
//                        [database executeUpdate:insertQuery_insert_TYC];
//                        
//                    }
//                    
//             //TCY Trade Line
//                    
//                    for (int i = 0; i<[arr_TCYTREND count]; i++) {
//                        
//                        NSString *str_MM=[[arr_TCYTREND objectAtIndex:i] objectForKey:@"MM"] ;
//                        NSString *str_MON=[[arr_TCYTREND objectAtIndex:i] objectForKey:@"MON"];
//                        
//                        NSString *str_SHIP_SUBTYPE_NAME=[[arr_TCYTREND objectAtIndex:i] objectForKey:@"SHIP_SUBTYPE"];
//                        NSString *str_SHIP_TYPE_NAME=[[arr_TCYTREND objectAtIndex:i] objectForKey:@"SHIP_TYPE"];
//                        
//                        NSString *str_TCY_ACT_AMT=[[arr_TCYTREND objectAtIndex:i] objectForKey:@"TCY_ACT_AMT"];
//                        NSString *str_TCY_ACT_DAYS=[[arr_TCYTREND objectAtIndex:i] objectForKey:@"TCY_ACT_DAYS"];
//                        
//                        
//                        
//                        NSString *insertQuery_insert_TCYTRADELINE = [NSString stringWithFormat:@"INSERT INTO TCYTREND1 (  MM ,  MON,  SHIP_SUBTYPE_NAME,  SHIP_TYPE_NAME, TCY_ACT_AMT,  TCY_ACT_DAYS ) VALUES ('%@', '%@', '%@', '%@','%@', '%@' )",str_MM,str_MON,str_SHIP_SUBTYPE_NAME,str_SHIP_TYPE_NAME,str_TCY_ACT_AMT,str_TCY_ACT_DAYS];
//                        
//                        [database executeUpdate:insertQuery_insert_TCYTRADELINE];
//                        
//                    }
//
//                    
//      //DashBoard_Data_Details
//                    
//           //OPEX_BGT_Detail
//                    for (int i = 0; i<[arr_OPEX_BGT_Details count]; i++) {
//                        
//                    NSString *str_ACTUALS_INR=[[arr_OPEX_BGT_Details objectAtIndex:i] objectForKey:@"ACTUALS_INR"];
//                    NSString *str_BUDG_INR=[[arr_OPEX_BGT_Details objectAtIndex:i] objectForKey:@"BUDG_INR"];
//                    NSString *str_FINYEAR=[[arr_OPEX_BGT_Details objectAtIndex:i] objectForKey:@"FINYEAR"];
//                    NSString *str_SHIP_NAME=[[arr_OPEX_BGT_Details objectAtIndex:i] objectForKey:@"SHIP_NAME"];
//                    NSString *str_SHIP_TYPE=[[arr_OPEX_BGT_Details objectAtIndex:i] objectForKey:@"SHIP_TYPE"];
//                        
//
//                        
//                    NSString *insertQuery_insert_Opex_bud_Details = [NSString stringWithFormat:@" INSERT INTO OPEX_BGT_DETAILS1 ( ACTUALS_INR, BUDG_INR, FINYEAR, SHIP_NAME, SHIP_TYPE) VALUES ('%@', '%@', '%@', '%@', '%@' )",str_ACTUALS_INR,str_BUDG_INR,str_FINYEAR,str_SHIP_NAME,str_SHIP_TYPE];
//                        
//                        [database executeUpdate:insertQuery_insert_Opex_bud_Details];
//                        
//                    }
//
//            //MANNING_BGT_Details
//           
//                    for (int i = 0; i<[arr_MANNING_BGT_Details count]; i++) {
//                        
//                        NSString *str_ACTUALS_INR=[[arr_MANNING_BGT_Details objectAtIndex:i] objectForKey:@"ACTUALS_INR"];
//                        NSString *str_BUDG_INR=[[arr_MANNING_BGT_Details objectAtIndex:i] objectForKey:@"BUDG_INR"];
//                        NSString *str_FINYEAR=[[arr_MANNING_BGT_Details objectAtIndex:i] objectForKey:@"FINYEAR"];
//                        NSString *str_SHIP_NAME=[[arr_MANNING_BGT_Details objectAtIndex:i] objectForKey:@"SHIP_NAME"];
//                        NSString *str_SHIP_TYPE=[[arr_MANNING_BGT_Details objectAtIndex:i] objectForKey:@"SHIP_TYPE"];
//                        
//                        
//                        NSString *insertQuery_insert_MANNING_BGT_Details = [NSString stringWithFormat:@" INSERT INTO MANNING_BGT_DETAILS1 ( ACTUALS_INR, BUDG_INR, FINYEAR, SHIP_NAME, SHIP_TYPE) VALUES ('%@', '%@', '%@', '%@', '%@' )",str_ACTUALS_INR,str_BUDG_INR,str_FINYEAR,str_SHIP_NAME,str_SHIP_TYPE];
//                        
//                        [database executeUpdate:insertQuery_insert_MANNING_BGT_Details];
//                        
//                    }
//                    
//             //DOWNTIME_TANKER_Details
//                    
//                    
//                    for (int i = 0; i<[arr_DOWNTIME_TANKER_Details count]; i++) {
//                        
//                        NSString *str_CATEGORY=[[arr_DOWNTIME_TANKER_Details objectAtIndex:i]  objectForKey:@"CATEGORY"];
//                        NSString *str_DOWNTIME_TYPE=[[arr_DOWNTIME_TANKER_Details objectAtIndex:i]  objectForKey:@"DWT_USD"];
//                        NSString *str_SHIP_NAME=[[arr_DOWNTIME_TANKER_Details objectAtIndex:i]  objectForKey:@"SHIP_NAME"];
//                        NSString *str_SHIP_TYPE=[[arr_DOWNTIME_TANKER_Details objectAtIndex:i]  objectForKey:@"SHIP_TYPE"];
//                        
//                        NSString *insertQuery_insert_DOWNTIME_TANKER_DETAILS = [NSString stringWithFormat:@" INSERT INTO DOWNTIME_TANKER_DETAILS1 (CATEGORY,DOWNTIME_TYPE,DWT_USD,SHIP_TYPE) VALUES ('%@', '%@', '%@', '%@' )",str_CATEGORY,str_DOWNTIME_TYPE,str_SHIP_NAME,str_SHIP_TYPE];
//                        
//                        [database executeUpdate:insertQuery_insert_DOWNTIME_TANKER_DETAILS];
//                        
//                    }
//
//                    
//                    //DOWNTIME_BULKER_Details
//                    
//                    
//                    for (int i = 0; i<[arr_DOWNTIME_BULKER_Details count]; i++) {
//                        
//                        NSString *str_CATEGORY=[[arr_DOWNTIME_BULKER_Details objectAtIndex:i]  objectForKey:@"CATEGORY"];
//                        NSString *str_DOWNTIME_TYPE=[[arr_DOWNTIME_BULKER_Details objectAtIndex:i]  objectForKey:@"DWT_USD"];
//                        NSString *str_SHIP_NAME=[[arr_DOWNTIME_BULKER_Details objectAtIndex:i]  objectForKey:@"SHIP_NAME"];
//                        NSString *str_SHIP_TYPE=[[arr_DOWNTIME_BULKER_Details objectAtIndex:i]  objectForKey:@"SHIP_TYPE"];
//                        
//                        
//                        NSString *insertQuery_insert_DOWNTIME_BULKER_DETAILS = [NSString stringWithFormat:@" INSERT INTO DOWNTIME_BULKER_DETAILS1 (CATEGORY,DOWNTIME_TYPE,DWT_USD,SHIP_TYPE) VALUES ('%@', '%@', '%@', '%@' )",str_CATEGORY,str_DOWNTIME_TYPE,str_SHIP_NAME,str_SHIP_TYPE];
//                        
//                        [database executeUpdate:insertQuery_insert_DOWNTIME_BULKER_DETAILS];
//                        
//                    }
//                    
//                    
//             [database close];
//                    
//                    
//                    
//                    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_updateReminder object:nil userInfo:nil];
//                     }
//                
//              [[AppHelper sharedInstance]hideIndicator];
//            }
//            else{
//                [AppHelper showAlertViewWithTag:11 title:APP_NAME message:ERROR_INVAILID delegate:nil cancelButtonTitle:Alert_Ok_Button otherButtonTitles:nil];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [AppHelper showAlertViewWithTag:11 title:APP_NAME message:ERROR_INTERNET delegate:nil cancelButtonTitle:Alert_Ok_Button otherButtonTitles:nil];
//            [[AppHelper sharedInstance]hideIndicator];
//            NSLog(@"Error: %@", error);
//        }];
//        
//        
//        [[NSOperationQueue mainQueue] addOperation:operation];
//    }
//    else{
//        [AppHelper showAlertViewWithTag:11 title:APP_NAME message:ERROR_INTERNET delegate:nil cancelButtonTitle:Alert_Ok_Button otherButtonTitles:nil];
//    }
//    
//}


//Checking  Data

-(BOOL)check_isdataAvailable{
    
    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *sqlSelectQuery_getclient = [NSString stringWithFormat:@"SELECT * FROM OPEX_BGT"];
    
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSString * str_OPEX_ACTUALS_INR;
    
    while([resultsWithName_cl1 next]) {
        
        
        str_OPEX_ACTUALS_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"ACTUALS_INR" ]];
    }
    
    if (str_OPEX_ACTUALS_INR.length==0) {
        [database close];
        
        return NO;
        
    }
    
    else{
        [database close];
        
        return YES;
        
    }
    
}

-(NSString *)databasePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"ShipwiseMIS.sqlite"];
    
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ShipwiseMIS.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success) {
            
            NSLog(@"Failed to create writable DB. Error '%@'.", [error localizedDescription]);
            
        } else {
            
            NSLog(@"DB copied.");
            
        }
        
    }else {
        
        NSLog(@"DB exists, no need to copy.");
        
    }
    NSLog(@"dbpath%@",dbPath);
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    
    [database open];
    
    // Dash Board  Tables
    
    NSString *insertQuery_OPEX_BGT = @"CREATE TABLE Opex_bgt ( ACTUALS_INR TEXT, BUDG_INR TEXT, FINYEAR TEXT, SHIP_TYPE TEXT )";
    
    NSString *insertQuery_MANNING_BGT = @"CREATE TABLE Manning_bgt (  ACTUALS_INR TEXT,  BUDG_INR TEXT,  FINYEAR TEXT,  SHIP_TYPE TEXT )";
    
    
    NSString *insertQuery_DOWNTIME_TANKER = @"CREATE TABLE DOWNTIME_TANKER1 (  CATEGORY TEXT,  DOWNTIME_TYPE TEXT,  DWT_USD TEXT,  SHIP_TYPE TEXT )";
    
    
    NSString *insertQuery_DOWNTIME_BULKER = @"CREATE TABLE DOWNTIME_BULKER1 (  CATEGORY TEXT,  DOWNTIME_TYPE TEXT,  DWT_USD TEXT,  SHIP_TYPE TEXT )";
    
    
    NSString *insertQuery_PROJ_ACTUALS = @"CREATE TABLE PROJ_ACTUALS1 (  FY_ACT_AMT TEXT,  FY_PROJ_AMT TEXT,  Q1_ACT_AMT TEXT,  Q1_PROJ_AMT TEXT, Q2_ACT_AMT TEXT,  Q2_PROJ_AMT TEXT, Q3_ACT_AMT TEXT,  Q3_PROJ_AMT TEXT, Q4_ACT_AMT TEXT,  Q4_PROJ_AMT TEXT, SHIP_TYPE_CD TEXT, SHIP_NAME TEXT  )";
    
    
    NSString *insertQuery_TCY = @"CREATE TABLE TCY1 (  SHIP_SUBTYPE_NAME TEXT,  SHIP_TYPE_NAME TEXT,  TCY_ACT_AMT TEXT )";
    
    
    NSString *insertQuery_TCYTREND = @"CREATE TABLE TCYTREND1 (  MM TEXT,  MON TEXT,  SHIP_SUBTYPE_NAME TEXT,  SHIP_TYPE_NAME TEXT, TCY_ACT_AMT TEXT,  TCY_ACT_DAYS TEXT )";
    
    
    
    
    // Dash Board Details Tables
    
    NSString *insertQuery_OPEX_BGT_DETAILS = @"CREATE TABLE Opex_details ( ACTUALS_INR TEXT, BUDG_INR TEXT, FINYEAR TEXT, SHIP_NAME TEXT, SHIP_TYPE TEXT )";
    
    NSString *insertQuery_MANNING_BGT_DETAILS = @"CREATE TABLE Manning_details ( ACTUALS_INR TEXT, BUDG_INR TEXT, FINYEAR TEXT, SHIP_NAME TEXT, SHIP_TYPE TEXT )";
    
    NSString *insertQuery_DOWNTIME_TANKER_DETAILS = @"CREATE TABLE DOWNTIME_TANKER_DETAILS1 (  CATEGORY TEXT,  DWT_USD TEXT, SHIP_NAME TEXT,  SHIP_TYPE TEXT )";
    
    NSString *insertQuery_DOWNTIME_BULKER_DETAILS = @"CREATE TABLE DOWNTIME_BULKER_DETAILS1 (  CATEGORY TEXT,  DWT_USD TEXT, SHIP_NAME TEXT,  SHIP_TYPE TEXT )";
    
    
    // Vessel Wise Tab
    
    
    NSString *insertQuery_Vessel_Budget_DTL = @"CREATE TABLE VESSEL_BGT_DTL (  Bgt_vsl_code TEXT,  Bgt_vsl_name TEXT,  Bgt_vst_type TEXT,  Bgt_class TEXT,  Bgt_budget_inr TEXT,  Bgt_budget_usd TEXT,  Bgt_deviation_inr TEXT,  Bgt_actuals_inr TEXT, Bgt_actuals_usd TEXT,  Bgt_variance_inr TEXT  , Bgt_current_budget TEXT )";

    
      NSString *insertQuery_Vessel_Budget_Total = @"CREATE TABLE VESSEL_BGT_TOTAL (  Bgt_vsl_code TEXT,  Bgt_vsl_name TEXT,  Bgt_vst_type TEXT,  Bgt_actuals_total_inr TEXT,  Bgt_actuals_total_roe TEXT,  Bgt_actuals_total_usd TEXT,  Bgt_budget_total_inr TEXT,  Bgt_budget_total_roe TEXT, Bgt_budget_total_usd TEXT,  Bgt_deviation_total_inr TEXT  , Bgt_total_current_budget TEXT ,Bgt_variance_total TEXT, Bgt_utilization_per TEXT )";

    
    
    
    
     NSString *insertQuery_VESSEL_DEVIATION_DTL = @"CREATE TABLE VESSEL_DEVIATION_DTL (  Dev_vsl_code TEXT,  Dev_vsl_name TEXT,  Dev_vst_type TEXT,  Dev_class TEXT,  Dev_amt TEXT,  Dev_subject TEXT )";
    
    
    
     NSString *insertQuery_VESSEL_DEVIATION_TOTAL = @"CREATE TABLE VESSEL_DEVIATION_TOTAL (  Dev_vsl_code TEXT,  Dev_vsl_name TEXT,  Dev_vst_type TEXT,  Dev_amt_total TEXT )";

    
    NSString *insertQuery_VESSEL_DWNTIME_DTL = @"CREATE TABLE VESSEL_DWNTIME_DTL (  Dow_vsl_code TEXT,  Dow_vsl_name TEXT,  Dow_vst_type TEXT,  Dow_dwn_date TEXT,  Dow_days TEXT,  Dow_category TEXT ,Dow_downtime_type TEXT, Dow_hire_loss TEXT, Dow_bunker_cost TEXT, Dow_misc_loss TEXT, Dow_total_loss TEXT  )";


    NSString *insertQuery_VESSEL_DWNTIME_TOTAL = @"CREATE TABLE VESSEL_DWNTIME_TOTAL (  Dow_vsl_code TEXT,  Dow_vsl_name TEXT,  Dow_vst_type TEXT, Dow_planned_usd TEXT, Dow_planned_days TEXT, Dow_unplanned_usd TEXT, Dow_unplanned_days TEXT, Dow_bulk_appr_date TEXT, Dow_tank_appr_date TEXT  )";

    
    
    
    
    NSString *insertQuery_VESSEL_DRYDOCK = @"CREATE TABLE VESSEL_DRYDOCK (  dry_vsl_code TEXT,  dry_vsl_name TEXT,  dry_vst_type TEXT, dry_dock_place TEXT, dry_dd_from_dt TEXT, dry_dd_to_dt TEXT, dry_dd_dense_rank TEXT, dry_loading_place TEXT, dry_stemmed_yard_cost TEXT, dry_stemmed_non_yard_cost TEXT, dry_stemmed_addtl_dock_exp TEXT, dry_stemmed_total_dd_cost TEXT, dry_stemmed_no_of_days TEXT, dry_actual_yard_cost TEXT, dry_actual_non_yard_cost TEXT, dry_actual_addtl_dock_exp TEXT, dry_actual_total_dd_cost TEXT, dry_actual_no_of_days TEXT, dry_saving_per_day TEXT, dry_appr_total_dd_cost TEXT, dry_remarks TEXt )";

    
    
    
    NSString *insertQuery_VESSEL_SIRE = @"CREATE TABLE VESSEL_SIRE (  Sire_vsl_code TEXT,  Sire_vsl_name TEXT,  Sire_vst_type TEXT, Sire_vetting_date TEXT, Sire_port_name TEXT, Sire_approver TEXT, Sire_approval_dt TEXT, Sire_approval_status TEXT, Sire_approval_active TEXT, Sire_inspection_company TEXT  )";

    
    
    
    
    
    
    
    
    
    
    [database executeUpdate:insertQuery_OPEX_BGT];
    [database executeUpdate:insertQuery_MANNING_BGT];
    [database executeUpdate:insertQuery_DOWNTIME_TANKER];
    [database executeUpdate:insertQuery_DOWNTIME_BULKER];
    [database executeUpdate:insertQuery_PROJ_ACTUALS];
    [database executeUpdate:insertQuery_TCY];
    [database executeUpdate:insertQuery_TCYTREND];
    
    // Vessel_wise Tab

    [database executeUpdate:insertQuery_Vessel_Budget_DTL];
    [database executeUpdate:insertQuery_Vessel_Budget_Total];
    [database executeUpdate:insertQuery_VESSEL_DEVIATION_DTL];
    [database executeUpdate:insertQuery_VESSEL_DEVIATION_TOTAL];
    [database executeUpdate:insertQuery_VESSEL_DWNTIME_DTL];
    [database executeUpdate:insertQuery_VESSEL_DWNTIME_TOTAL];

    
    // DryDock  Tab
    [database executeUpdate:insertQuery_VESSEL_DRYDOCK];

    // Siri  Tab
    [database executeUpdate:insertQuery_VESSEL_SIRE];

    
    // Dash Board Details
    
    
    [database executeUpdate:insertQuery_OPEX_BGT_DETAILS];
    [database executeUpdate:insertQuery_MANNING_BGT_DETAILS];
    [database executeUpdate:insertQuery_DOWNTIME_TANKER_DETAILS];
    [database executeUpdate:insertQuery_DOWNTIME_BULKER_DETAILS];
    
    
    
    
    
    [database close];
    
    return dbPath;
    
}

//Featching Opexdata

-(NSMutableArray*)GetOPEX_BGT_All
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM Opex_bgt"];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_act_inr=[[NSMutableArray alloc]init];

        
        NSString *str_ACTUALS_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"ACTUALS_INR" ]];
        
        NSString *str_BUDG_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"BUDG_INR" ]];
        NSString *str_FINYEAR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"FINYEAR" ]];
        
        NSString *str_SHIP_TYPE = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
        

        [arr_act_inr addObject:str_ACTUALS_INR];
        [arr_act_inr addObject:str_BUDG_INR];
        [arr_act_inr addObject:str_FINYEAR];
        [arr_act_inr addObject:str_SHIP_TYPE];
        
        [arr addObject:arr_act_inr];

    }
    
    [database close];
    
    return arr;
    
}

//Featching Manning

-(NSMutableArray*)Get_MANNING_BGT_All
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM Manning_bgt"];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_act_inr=[[NSMutableArray alloc]init];

        NSString *str_ACTUALS_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"ACTUALS_INR" ]];
        
        NSString *str_BUDG_INR =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"BUDG_INR" ]];
        NSString *str_FINYEAR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"FINYEAR" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
        
        
        [arr_act_inr addObject:str_ACTUALS_INR];
        [arr_act_inr addObject:str_BUDG_INR];
        [arr_act_inr addObject:str_FINYEAR];
        [arr_act_inr addObject:str_SHIP_TYPE];
        
        
        [arr addObject:arr_act_inr];

    }
    [database close];
    
    return arr;
    
}

-(NSMutableArray*)Get_DOWNTIME_TANKER_AllbyDowntime_type:(NSString *)type
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM DOWNTIME_TANKER1 Where  DOWNTIME_TYPE = '%@'",type];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_category=[[NSMutableArray alloc]init];

        
        NSString *str_CATEGORY = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"CATEGORY" ]];
        
        NSString *str_DOWNTIME_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"DOWNTIME_TYPE" ]];
        
        NSString *str_DWT_USD = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"DWT_USD" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
        
        
        [arr_category addObject:str_CATEGORY];
        [arr_category addObject:str_DOWNTIME_TYPE];
        [arr_category addObject:str_DWT_USD];
        [arr_category addObject:str_SHIP_TYPE];
        
        [arr addObject:arr_category];

    }
    [database close];
    
    return arr;
    
}


-(NSMutableArray*)Get_DOWNTIME_BULKER_AllbyDowntime_type:(NSString *)type
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM DOWNTIME_BULKER1 Where  DOWNTIME_TYPE = '%@'",type];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_category=[[NSMutableArray alloc]init];

        
        NSString *str_CATEGORY = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"CATEGORY" ]];
        
        NSString *str_DOWNTIME_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"DOWNTIME_TYPE" ]];
        
        NSString *str_DWT_USD = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"DWT_USD" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
        
        
        [arr_category addObject:str_CATEGORY];
        [arr_category addObject:str_DOWNTIME_TYPE];
        [arr_category addObject:str_DWT_USD];
        [arr_category addObject:str_SHIP_TYPE];
        
        [arr addObject:arr_category];

    }
    
    [database close];
    
    return arr;
    
}


//ProjvsActual
-(NSMutableArray *)GET_PROJ_ACTUALS_ALL:(NSString *)ShipType
{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"select * from PROJ_ACTUALS1 Where SHIP_TYPE_CD = '%@'",ShipType ];
                                         
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
                                         

    NSMutableArray *arr=[[NSMutableArray alloc]init];
    

    
                                         
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_Wsa=[[NSMutableArray alloc]init];
        
        NSString *str_shipName = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE_CD"]];
        
        
        NSString *str_Q1_PROJ_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q1_PROJ_AMT"]];
        NSString *str_Q1_ACT_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q1_ACT_AMT"]];
        
        NSString *str_Q2_PROJ_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q2_PROJ_AMT"]];
        NSString *str_Q2_ACT_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q2_ACT_AMT"]];
        
        
        NSString *str_Q3_PROJ_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q3_PROJ_AMT"]];
        NSString *str_Q3_ACT_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q3_ACT_AMT"]];
        
        
        NSString *str_Q4_PROJ_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q4_PROJ_AMT"]];
        NSString *str_Q4_ACT_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Q4_ACT_AMT"]];
        
        NSString *str_FY_PROJ_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"FY_PROJ_AMT"]];
        NSString *str_FY_ACT_AMT = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"FY_ACT_AMT"]];
        
        
        //       [arr_Wsa addObject:str_sunbtypename];
        
        [arr_Wsa addObject:str_shipName];
        
        [arr_Wsa addObject:str_Q1_PROJ_AMT];
        [arr_Wsa addObject:str_Q1_ACT_AMT];
        
        [arr_Wsa addObject:str_Q2_PROJ_AMT];
        [arr_Wsa addObject:str_Q2_ACT_AMT];
        
        [arr_Wsa addObject:str_Q3_PROJ_AMT];
        [arr_Wsa addObject:str_Q3_ACT_AMT];
        
        [arr_Wsa addObject:str_Q4_PROJ_AMT];
        [arr_Wsa addObject:str_Q4_ACT_AMT];
        
        [arr_Wsa addObject:str_FY_PROJ_AMT];
        [arr_Wsa addObject:str_FY_ACT_AMT];
        
        
        
        
        [arr addObject:arr_Wsa];
        
    }
    
    
    [database close];
    return arr;
    
}


-(NSMutableArray *)GET_TYC_ALLbyShipType:(NSString *)shiptype
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM TCY1 WHERE SHIP_TYPE_NAME = '%@'",shiptype];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_shiptypename=[[NSMutableArray alloc]init];

        
        NSString *str_SHIP_SUBTYPE_NAME=[NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_SUBTYPE_NAME" ]];
        
        NSString *str_TCY_ACT_AMT=[NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"TCY_ACT_AMT" ]];
        
        NSString *str_SHIP_TYPE =[NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE_NAME" ]];
        
        
        [arr_shiptypename addObject:str_SHIP_SUBTYPE_NAME];
        [arr_shiptypename addObject:str_TCY_ACT_AMT];
        [arr_shiptypename addObject:str_SHIP_TYPE];
        
        [arr addObject:arr_shiptypename];

    }
    

    
    [database close];
    
    return arr;
    
}


-(NSString *)GetTYC_Sum_ByShipType:(NSString *)shipType
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"select TCY_ACT_AMT,sum(TCY_ACT_AMT)from TCY1 Where SHIP_TYPE_NAME ='%@' ",shipType];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];

    NSString *str_SHIP_SUBTYPE_NAME = [[NSString alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        
    str_SHIP_SUBTYPE_NAME=[NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(TCY_ACT_AMT)"]];
        
    }
    
    
    [database close];
    
    return str_SHIP_SUBTYPE_NAME;
}




//DashBoard_Details

//DashBoard_ opex Details
-(NSMutableArray *)GET_Opex_DetailsByShipType:(NSString *)ShiptypeName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM Opex_details Where SHIP_TYPE ='%@' ",ShiptypeName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_act_inr=[[NSMutableArray alloc]init];
        
        
        NSString *str_ACTUALS_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"ACTUALS_INR" ]];
        
        NSString *str_BUDG_INR =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"BUDG_INR" ]];
        NSString *str_FINYEAR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"FINYEAR" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
         NSString *str_SHIP_NAME =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_NAME" ]];
        
        [arr_act_inr addObject:str_ACTUALS_INR];
        [arr_act_inr addObject:str_BUDG_INR];
        [arr_act_inr addObject:str_FINYEAR];
        [arr_act_inr addObject:str_SHIP_TYPE];
        [arr_act_inr addObject:str_SHIP_NAME];

        [arr addObject:arr_act_inr];
        
    }
    
    [database close];
    
    return arr;
    
}

//DashBoard_ Manning Details

-(NSMutableArray *)GET_Manning_DetailsByShipType:(NSString *)ShiptypeName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM Manning_details Where SHIP_TYPE ='%@' ",ShiptypeName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_act_inr=[[NSMutableArray alloc]init];
        
        
        NSString *str_ACTUALS_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"ACTUALS_INR" ]];
        
        NSString *str_BUDG_INR =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"BUDG_INR" ]];
        NSString *str_FINYEAR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"FINYEAR" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
        NSString *str_SHIP_NAME =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_NAME" ]];
        
        [arr_act_inr addObject:str_ACTUALS_INR];
        [arr_act_inr addObject:str_BUDG_INR];
        [arr_act_inr addObject:str_FINYEAR];
        [arr_act_inr addObject:str_SHIP_TYPE];
        [arr_act_inr addObject:str_SHIP_NAME];
        
        [arr addObject:arr_act_inr];
        
    }
    
    [database close];
    
    return arr;
    
}
//Tradeline

-(NSMutableArray *)GET_tradeline_By_ShipTypeName:(NSString *)shiptypeName
{
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"select * from TCYTREND1 where SHIP_TYPE_NAME = '%@' ",shiptypeName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_act_inr=[[NSMutableArray alloc]init];
        
        
        NSString *str_ACTUALS_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"MM" ]];
        
        NSString *str_BUDG_INR =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"MON" ]];
        NSString *str_FINYEAR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_SUBTYPE_NAME" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"TCY_ACT_AMT" ]];
        NSString *str_SHIP_NAME =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"TCY_ACT_DAYS" ]];
        
        [arr_act_inr addObject:str_ACTUALS_INR];
        [arr_act_inr addObject:str_BUDG_INR];
        [arr_act_inr addObject:str_FINYEAR];
        [arr_act_inr addObject:str_SHIP_TYPE];
        [arr_act_inr addObject:str_SHIP_NAME];
        
        [arr addObject:arr_act_inr];
        
    }
    
    [database close];
    
    return arr;

}



//downtime Details

-(NSMutableArray *)GET_DownTime_DetailsByCategory:(NSString *)Category
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM DOWNTIME_TANKER_DETAILS1 Where CATEGORY ='%@' ",Category ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_act_inr=[[NSMutableArray alloc]init];
        
        
        NSString *str_CATEGORY = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"CATEGORY" ]];
        
        NSString *str_DWT_USD =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"DWT_USD" ]];
        NSString *str_SHIP_NAME = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_NAME" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
        
        [arr_act_inr addObject:str_CATEGORY];
        [arr_act_inr addObject:str_DWT_USD];
        [arr_act_inr addObject:str_SHIP_NAME];
        [arr_act_inr addObject:str_SHIP_TYPE];

        [arr addObject:arr_act_inr];
        
    }
    
    [database close];
    
    return arr;
    
}


-(NSMutableArray *)GET_DownTime_DetailsByCategoryBulker:(NSString *)Category
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM DOWNTIME_BULKER_DETAILS1 Where CATEGORY ='%@' ",Category ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_act_inr=[[NSMutableArray alloc]init];
        
        
        NSString *str_CATEGORY = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"CATEGORY" ]];
        
        NSString *str_DWT_USD =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"DWT_USD" ]];
        NSString *str_SHIP_NAME = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_NAME" ]];
        
        NSString *str_SHIP_TYPE =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"SHIP_TYPE" ]];
        
        [arr_act_inr addObject:str_CATEGORY];
        [arr_act_inr addObject:str_DWT_USD];
        [arr_act_inr addObject:str_SHIP_NAME];
        [arr_act_inr addObject:str_SHIP_TYPE];
        
        [arr addObject:arr_act_inr];
        
    }
    
    [database close];
    
    return arr;
    
}

-(NSString *)GetDownTimeBUlkerDetails_TYC_Sum_ByCategory:(NSString *)category
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"select DWT_USD,sum(DWT_USD)from DOWNTIME_BULKER_DETAILS1 Where  CATEGORY='%@' ",category];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSString *str_SHIP_SUBTYPE_NAME = [[NSString alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        
        str_SHIP_SUBTYPE_NAME=[NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(DWT_USD)"]];
        
    }
    
    
    [database close];
    
    return str_SHIP_SUBTYPE_NAME;
}

-(NSString *)GetDownTimeTankerDetails_TYC_Sum_ByCategory:(NSString *)category
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"select DWT_USD,sum(DWT_USD)from DOWNTIME_TANKER_DETAILS1 Where  CATEGORY='%@' ",category];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSString *str_SHIP_SUBTYPE_NAME = [[NSString alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        
        str_SHIP_SUBTYPE_NAME=[NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(DWT_USD)"]];
        
    }
    
    
    [database close];
    
    return str_SHIP_SUBTYPE_NAME;
}


#pragma mark - getting allshiptype And shipNames

-(NSMutableArray *)GetAllShipType_And_ShipNames
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT DISTINCT Bgt_vsl_name,Bgt_vst_type  FROM 'VESSEL_BGT_DTL' ORDER BY Bgt_vsl_name" ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableArray *arr_all_shiptypeandNames=[[NSMutableArray alloc]init];
        
        
        NSString *str_vesselName = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_vsl_name" ]];
        
        NSString *str_vesselType =  [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_vst_type" ]];

        [arr_all_shiptypeandNames addObject:str_vesselName];
        [arr_all_shiptypeandNames addObject:str_vesselType];

        
        [arr addObject:arr_all_shiptypeandNames];
        
    }
    
    [database close];
    
    return arr;
    
    
}


#pragma mark - getting Vessel budgetValues by shipNames

-(NSMutableArray *)GetVessel_BudgetByShipName:(NSString *)ShipName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT sum(Bgt_budget_inr),sum(Bgt_deviation_inr),sum(Bgt_actuals_inr),sum(Bgt_variance_inr),sum(Bgt_budget_usd),sum(Bgt_actuals_usd) FROM 'VESSEL_BGT_DTL' where  Bgt_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
       NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        NSString *str_Bgt_Budget = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_budget_inr)" ]];
        
        NSString *str_Bgt_Deviation = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_deviation_inr)" ]];
        
        NSString *str_Bgt_Actual = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_actuals_inr)" ]];
        
        NSString *str_Bgt_Variance = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_variance_inr)" ]];
        
        
        NSString *str_Bgt_Budget_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_budget_usd)" ]];

        NSString *str_Bgt_Actual_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_actuals_usd)" ]];

        [arr_shipwise_BudgetValues addObject:str_Bgt_Budget];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Deviation];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Actual];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Variance];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Budget_usd];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Actual_usd];

        
//        [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr_shipwise_BudgetValues;
    
    
}



-(NSMutableArray *)GetVessel_Budget_DetailsByShipName:(NSString *)ShipName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_BGT_DTL where Bgt_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];

        
        NSString *str_Bgt_class = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_class" ]];
        
        NSString *str_Bgt_Budget = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_inr" ]];
        
        NSString *str_Bgt_Deviation = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_current_budget" ]];

        NSString *str_Bgt_Actual = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_inr" ]];
        
        NSString *str_Bgt_Variance = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_variance_inr" ]];
        
        NSString *str_Bgt_budget_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_usd" ]];

        NSString *str_Bgt_actual_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_usd" ]];

        
        [arr_shipwise_BudgetValues addObject:str_Bgt_class];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Budget];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Deviation];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Actual];
        [arr_shipwise_BudgetValues addObject:str_Bgt_Variance];
        
        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_usd];
        [arr_shipwise_BudgetValues addObject:str_Bgt_actual_usd];

                [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr;
    
  
        
}

-(NSMutableArray *)GetVessel_Budget_Total_DetailsByShipName:(NSString *)ShipName
{
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_BGT_TOTAL where Bgt_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];

    while([resultsWithName_cl1 next]) {
        
        
        
        NSString *str_Bgt_budget_total_inr = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_inr" ]];
        
        NSString *str_Bgt_total_current_budget = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_total_current_budget" ]];
        
        NSString *str_Bgt_actuals_total_inr= [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_inr" ]];
        
        NSString *str_Bgt_variance_total_roe = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_variance_total" ]];
        
        NSString *str_Bgt_utilization_per = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_utilization_per" ]];
        
        
        NSString *str_Bgt_budget_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_usd" ]];
        
        NSString *str_Bgt_actuals_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_usd" ]];

        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_inr];
        [arr_shipwise_BudgetValues addObject:str_Bgt_total_current_budget];
        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_inr];
        [arr_shipwise_BudgetValues addObject:str_Bgt_variance_total_roe];
        [arr_shipwise_BudgetValues addObject:str_Bgt_utilization_per];
        
        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_usd];
        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_usd];

//        [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr_shipwise_BudgetValues;
    
}


-(NSMutableArray *)GetBudget_Details_sumByShipName:(NSString *)ShipName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select  sum(Bgt_budget_inr),sum(Bgt_current_budget),sum(Bgt_actuals_inr),sum(Bgt_variance_inr),sum(Bgt_budget_usd),sum(Bgt_actuals_usd) from VESSEL_BGT_DTL  Where   Bgt_vsl_name ='%@' ",ShipName];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        
         NSString *str_sum_Bgt_budget_inr = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_budget_inr)"]];
        
        NSString *str_sum_Bgt_current_budget = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_current_budget)"]];
        
        NSString *str_sum_Bgt_actuals_inr = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_actuals_inr)"]];

        NSString *str_sum_Bgt_variance_inr = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_variance_inr)"]];

        NSString *str_sum_Bgt_budget_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_budget_usd)"]];

        NSString *str_sum_Bgt_actuals_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Bgt_actuals_usd)"]];

        
        [arr_shipwise_BudgetValues addObject:str_sum_Bgt_budget_inr];
        [arr_shipwise_BudgetValues addObject:str_sum_Bgt_current_budget];
        [arr_shipwise_BudgetValues addObject:str_sum_Bgt_actuals_inr];
        [arr_shipwise_BudgetValues addObject:str_sum_Bgt_variance_inr];
        [arr_shipwise_BudgetValues addObject:str_sum_Bgt_budget_usd];
        [arr_shipwise_BudgetValues addObject:str_sum_Bgt_actuals_usd];

    }
    
    
    [database close];
    
    return arr_shipwise_BudgetValues;
}




-(NSString *)GetVessel_Deviation_Total_ByShipName:(NSString *)ShipName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_DEVIATION_TOTAL where Dev_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
//    NSMutableArray *arr=[[NSMutableArray alloc]init];
//    NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];
    NSString *str_Dev_amt_total = [NSString new];
    while([resultsWithName_cl1 next]) {
        
        
    str_Dev_amt_total = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dev_amt_total" ]];
        
//        NSString *str_Bgt_total_current_budget = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_total_current_budget" ]];
//        
//        NSString *str_Bgt_actuals_total_inr= [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_inr" ]];
//        
//        NSString *str_Bgt_variance_total_roe = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_variance_total_roe" ]];
//        
//        NSString *str_Bgt_budget_total_roe = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_roe" ]];
//        
//        
//        NSString *str_Bgt_budget_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_usd" ]];
//        
//        NSString *str_Bgt_actuals_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_usd" ]];
        
      //  [arr_shipwise_BudgetValues addObject:str_Dev_amt_total];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_total_current_budget];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_inr];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_variance_total_roe];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_roe];
//        
//        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_usd];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_usd];
        
        //        [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return str_Dev_amt_total;
    
    
}

-(NSMutableArray *)GetVessel_Deviation_DetailsByShipName:(NSString *)ShipName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_DEVIATION_DTL where Dev_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];
        
        
        NSString *str_Dev_class = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dev_class" ]];
        
        NSString *str_Dev_amt = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dev_amt" ]];
        
        NSString *str_Dev_subject = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dev_subject" ]];
//        
//        NSString *str_Bgt_Actual = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_inr" ]];
//        
//        NSString *str_Bgt_Variance = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_variance_inr" ]];
//        
//        NSString *str_Bgt_budget_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_usd" ]];
//        
//        NSString *str_Bgt_actual_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_usd" ]];
        
        
        [arr_shipwise_BudgetValues addObject:str_Dev_class];
        [arr_shipwise_BudgetValues addObject:str_Dev_amt];
        [arr_shipwise_BudgetValues addObject:str_Dev_subject];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_Actual];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_Variance];
//        
//        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_usd];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_actual_usd];
//        
        [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr;
  
    
}

-(NSString *)GetDevation_sumByShipName:(NSString *)ShipName
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"select  Dev_amt ,sum(Dev_amt)from VESSEL_DEVIATION_DTL  Where   Dev_vsl_name ='%@' ",ShipName];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSString *str_SHIP_SUBTYPE_NAME = [[NSString alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        
        str_SHIP_SUBTYPE_NAME=[NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Dev_amt)"]];
        
    }
    
    
    [database close];
    
    return str_SHIP_SUBTYPE_NAME;
}



-(NSMutableArray *)GetVessel_DownTime_Total_DetailsByShipName:(NSString *)ShipName
{
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_DWNTIME_TOTAL where  Dow_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        
        
        NSString *str_Dow_planned_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_planned_usd" ]];
        
        NSString *str_Dow_planned_days = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_planned_days" ]];
        
        NSString *str_Dow_unplanned_usd= [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_unplanned_usd" ]];
        
        NSString *str_Dow_unplanned_days = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_unplanned_days" ]];
        
//        NSString *str_Bgt_budget_total_roe = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_roe" ]];
//        
//        
//        NSString *str_Bgt_budget_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_usd" ]];
//        
//        NSString *str_Bgt_actuals_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_usd" ]];
        
        [arr_shipwise_BudgetValues addObject:str_Dow_planned_usd];
        [arr_shipwise_BudgetValues addObject:str_Dow_planned_days];
        [arr_shipwise_BudgetValues addObject:str_Dow_unplanned_usd];
        [arr_shipwise_BudgetValues addObject:str_Dow_unplanned_days];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_roe];
//        
//        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_usd];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_usd];
        
        //        [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr_shipwise_BudgetValues;
    
}


-(NSMutableArray *)GetVessel_DownTime_DetailsByShipName:(NSString *)ShipName downtimetype:(NSString *)Type
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"select * from VESSEL_DWNTIME_DTL where  Dow_vsl_name = '%@' And Dow_downtime_type ='%@'",ShipName ,Type];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];
        
        
        NSString *str_Dow_category = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_category" ]];
        
        NSString *str_Dow_total_loss = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_total_loss" ]];
        
        NSString *str_Dow_bunker_cost = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_bunker_cost" ]];
        
        NSString *str_Dow_hire_loss  = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_hire_loss" ]];
        
        NSString *str_Dow_days = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_days" ]];
        
        NSString *str_Dow_dwn_date = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Dow_dwn_date" ]];
        

        
        
        [arr_shipwise_BudgetValues addObject:str_Dow_category];
        [arr_shipwise_BudgetValues addObject:str_Dow_total_loss];
        [arr_shipwise_BudgetValues addObject:str_Dow_bunker_cost];
        [arr_shipwise_BudgetValues addObject:str_Dow_hire_loss];
        [arr_shipwise_BudgetValues addObject:str_Dow_days];
        
        [arr_shipwise_BudgetValues addObject:str_Dow_dwn_date];
        
        [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr;
    
}

-(NSMutableArray *)GetVessel_DownTime_Sumfor_PlannedByShipName:(NSString *)ShipName downtimetype:(NSString *)Type
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select  sum(Dow_total_loss),sum(Dow_hire_loss),sum(Dow_bunker_cost),sum(Dow_days) from VESSEL_DWNTIME_DTL  Where   Dow_vsl_name = '%@' AND Dow_downtime_type ='%@' ",ShipName ,Type];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];

    while([resultsWithName_cl1 next]) {
        
        
        
        NSString *str_sum_Dow_total_loss = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Dow_total_loss)" ]];
        
        NSString *str_sum_Dow_hire_loss = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Dow_hire_loss)" ]];
        
        NSString *str_sum_Dow_bunker_cost = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Dow_bunker_cost)" ]];
        
        NSString *str_sum_Dow_days  = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"sum(Dow_days)" ]];
        

        
        
        
        
        [arr_shipwise_BudgetValues addObject:str_sum_Dow_total_loss];
        [arr_shipwise_BudgetValues addObject:str_sum_Dow_hire_loss];
        [arr_shipwise_BudgetValues addObject:str_sum_Dow_bunker_cost];
        [arr_shipwise_BudgetValues addObject:str_sum_Dow_days];
        
        
       // [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr_shipwise_BudgetValues;
    
}
-(NSMutableArray *)GetVessel_DryDock_DetailsByShipName:(NSString *)ShipName
{
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_DRYDOCK where dry_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];

        
        NSString *str_dry_dd_from_dt = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"dry_dd_from_dt" ]];
        
        NSString *str_dry_appr_total_dd_cost = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"dry_appr_total_dd_cost" ]];
        
        NSString *str_dry_dd_to_dt = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"dry_dd_to_dt" ]];
        
        NSString *str_dry_actual_no_of_days = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"dry_actual_no_of_days" ]];
//
//        NSString *str_Bgt_utilization_per = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_utilization_per" ]];
//        
//        
//        NSString *str_Bgt_budget_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_usd" ]];
//        
//        NSString *str_Bgt_actuals_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_usd" ]];
        
        [arr_shipwise_BudgetValues addObject:str_dry_dd_from_dt];
        [arr_shipwise_BudgetValues addObject:str_dry_appr_total_dd_cost];
        [arr_shipwise_BudgetValues addObject:str_dry_dd_to_dt];
        [arr_shipwise_BudgetValues addObject:str_dry_actual_no_of_days];
        
//        [arr_shipwise_BudgetValues addObject:str_Bgt_variance_total_roe];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_utilization_per];
//        
//        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_usd];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_usd];
        
                [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr;
    
}

-(NSMutableArray *)GetVessel_SIRE_DetailsByShipName:(NSString *)ShipName
{
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_SIRE where Sire_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];

        
        NSString *str_Sire_inspection_company = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Sire_inspection_company" ]];
        
        NSString *str_Sire_vetting_date = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Sire_vetting_date" ]];
        
//        NSString *str_Bgt_actuals_total_inr= [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_inr" ]];
//        
//        NSString *str_Bgt_variance_total_roe = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_variance_total" ]];
//        
//        NSString *str_Bgt_utilization_per = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_utilization_per" ]];
//        
//        
//        NSString *str_Bgt_budget_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_usd" ]];
//        
//        NSString *str_Bgt_actuals_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_usd" ]];
        
        [arr_shipwise_BudgetValues addObject:str_Sire_inspection_company];
        [arr_shipwise_BudgetValues addObject:str_Sire_vetting_date];
        
//        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_inr];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_variance_total_roe];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_utilization_per];
//        
//        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_usd];
//        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_usd];
        
             [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr;
    
}

-(NSMutableArray *)GetVessel_SIRE_Approvel_DetailsByShipName:(NSString *)ShipName
{
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"Select * from VESSEL_SIRE where Sire_vsl_name = '%@'",ShipName ];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    while([resultsWithName_cl1 next]) {
        
        NSMutableArray *arr_shipwise_BudgetValues=[[NSMutableArray alloc]init];
        
        
        NSString *str_Sire_inspection_company = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Sire_approver" ]];
        
        NSString *str_Sire_vetting_date = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Sire_approval_dt" ]];
        
        //        NSString *str_Bgt_actuals_total_inr= [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_inr" ]];
        //
        //        NSString *str_Bgt_variance_total_roe = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_variance_total" ]];
        //
        //        NSString *str_Bgt_utilization_per = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_utilization_per" ]];
        //
        //
        //        NSString *str_Bgt_budget_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_budget_total_usd" ]];
        //
        //        NSString *str_Bgt_actuals_total_usd = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"Bgt_actuals_total_usd" ]];
        
        [arr_shipwise_BudgetValues addObject:str_Sire_inspection_company];
        [arr_shipwise_BudgetValues addObject:str_Sire_vetting_date];
        
        //        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_inr];
        //        [arr_shipwise_BudgetValues addObject:str_Bgt_variance_total_roe];
        //        [arr_shipwise_BudgetValues addObject:str_Bgt_utilization_per];
        //
        //        [arr_shipwise_BudgetValues addObject:str_Bgt_budget_total_usd];
        //        [arr_shipwise_BudgetValues addObject:str_Bgt_actuals_total_usd];
        
        [arr addObject:arr_shipwise_BudgetValues];
        
    }
    
    [database close];
    
    return arr;
    
}


@end
