//
//  AppHelper.h
//  IntroduceThem
//
//  Created by Aravind Kumar on 13/06/11.
//  Copyright 2011 Tata Consultant Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface AppHelper : NSObject {
MBProgressHUD *HUD;
}
+ (AppHelper *)sharedInstance;
- (MBProgressHUD *)getCurrentHud;
- (void )showIndicator;
- (void )hideIndicator;
- (void )showIndicator2;
- (void )hideIndicator2;
+ (id)alloc;
+(NSArray *)allPropertyNamesOfClass:(Class)class;
+ (AppDelegate*) appDelegate;
+(void)saveToUserDefaults:(id)value withKey:(NSString*)key;
+(NSString*)userDefaultsForKey:(NSString*)key;
+(void)removeFromUserDefaultsWithKey:(NSString*)key;

+ (void) showAlertViewWithTag:(NSInteger)tag title:(NSString*)title message:(NSString*)msg delegate:(id)delegate
            cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles;
+ (NSString *)getCurrentLanguage;
+(UIImage *)normalizedImage:(UIImage *)image;
-(UIPopoverController *)curruntPopOver;
-(void)initPopoverWithViewController:(UIViewController*)vc direction:(UIPopoverArrowDirection)arrowDirection senderRect:(CGRect)rect inView:(UIView *)inView;
//make color code
+(UIColor *)colorFromHexString:(NSString *)hexString ;
+(NSString *)hexFromUIColor:(UIColor *)color;
+(BOOL)emailValidate:(NSString *)checkString;
+(UIViewController *)intialiseViewControllerFromMainStoryboardWithName:(NSString *)vcName;
+(NSString *)nullCheck:(id)str;
-(NSDate*)getNextYearDate:(NSDate*)date year:(NSString*)year ;
-(NSDate*)getDate:(NSDate*)date year:(NSString*)year month:(NSString*)month;
@end
