//
//  DBManager.h
//  MIS
//
//  Created by Vikas Lov on 5/1/15.
//  Copyright (c) 2015 Vikas Lov. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBManager : NSObject

-(NSString *)databasePath;
-(BOOL)check_isdataAvailable;

//-(void)gettingDataService;

-(NSMutableArray*)GetOPEX_BGT_All;
-(NSMutableArray*)Get_MANNING_BGT_All;
-(NSMutableArray*)Get_DOWNTIME_TANKER_All;
-(NSMutableArray*)Get_DOWNTIME_BULKER_All;
-(NSMutableArray *)GET_PROJ_ACTUALS_ALL;

-(NSMutableArray *)GET_PROJ_ACTUALS_ALL:(NSString *)ShipType;
-(NSMutableArray *)GET_TYC_ALL;
-(NSMutableArray *)GET_TYC_ALLbyShipType:(NSString *)shiptype;
-(NSMutableArray*)Get_DOWNTIME_TANKER_AllbyDowntime_type:(NSString *)type;
-(NSString *)GetTYC_Sum_ByShipType:(NSString *)shipType;
-(NSMutableArray*)Get_DOWNTIME_BULKER_AllbyDowntime_type:(NSString *)type;
//Details
-(NSMutableArray *)GET_Opex_DetailsByShipType:(NSString *)ShiptypeName;

-(NSMutableArray *)GET_Manning_DetailsByShipType:(NSString *)ShiptypeName;

-(NSMutableArray *)GET_DownTime_DetailsByCategory:(NSString *)Category;
-(NSMutableArray *)GET_DownTime_DetailsByCategoryBulker:(NSString *)Category;
-(NSString *)GetDownTimeBUlkerDetails_TYC_Sum_ByCategory:(NSString *)category;
-(NSString *)GetDownTimeTankerDetails_TYC_Sum_ByCategory:(NSString *)category;
-(NSMutableArray *)GET_tradeline_By_ShipTypeName:(NSString *)shiptypeName;

-(NSMutableArray *)GetAllShipType_And_ShipNames;
-(NSMutableArray *)GetVessel_BudgetByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetVessel_Budget_DetailsByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetVessel_Budget_Total_DetailsByShipName:(NSString *)ShipName;
-(NSString *)GetVessel_Deviation_Total_ByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetVessel_Deviation_DetailsByShipName:(NSString *)ShipName;
-(NSString *)GetDevation_sumByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetVessel_DownTime_Total_DetailsByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetVessel_DownTime_DetailsByShipName:(NSString *)ShipName downtimetype:(NSString *)Type;
-(NSMutableArray *)GetVessel_DryDock_DetailsByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetVessel_SIRE_DetailsByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetBudget_Details_sumByShipName:(NSString *)ShipName;
-(NSMutableArray *)GetVessel_DownTime_Sumfor_PlannedByShipName:(NSString *)ShipName downtimetype:(NSString *)Type;
-(NSMutableArray *)GetVessel_SIRE_Approvel_DetailsByShipName:(NSString *)ShipName;
@end
