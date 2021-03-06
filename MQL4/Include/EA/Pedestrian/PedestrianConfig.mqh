//+------------------------------------------------------------------+
//|                                             PedestrianConfig.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <EA\PortfolioManagerBasedBot\BasePortfolioManagerBotConfig.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct PedestrianConfig : public BasePortfolioManagerBotConfig
  {
public:
   int               botPeriod;
   ENUM_TIMEFRAMES   botTimeframe;
   double            botMinimumTpSlDistance;
   double            botSkew;
   double            botAtrMultiplier;
   int               botRangePeriod;
   int               botIntradayPeriod;
   ENUM_TIMEFRAMES   botIntradayTimeframe;
  };
//+------------------------------------------------------------------+
