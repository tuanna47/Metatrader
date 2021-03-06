//+------------------------------------------------------------------+
//|                                        KeltnerPullbackTrader.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Signals\AtrRange.mqh>
#include <Signals\MovingAveragePullback.mqh>
#include <EA\PortfolioManagerBasedBot\BasePortfolioManagerBot.mqh>
#include <EA\KeltnerPullbackTrader\KeltnerPullbackTraderConfig.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class KeltnerPullbackTrader : public BasePortfolioManagerBot
  {
public:
   void              KeltnerPullbackTrader(KeltnerPullbackTraderConfig &config);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void KeltnerPullbackTrader::KeltnerPullbackTrader(KeltnerPullbackTraderConfig &config):BasePortfolioManagerBot(config)
  {
   int i;
   for(i=0;i<config.parallelSignals;i++)
     {
      this.signalSet.Add(
                         new AtrRange(
                         config.keltnerPullbackAtrPeriod,
                         config.keltnerPullbackAtrMultiplier,
                         config.keltnerPullbackTimeframe,
                         config.atrSkew,
                         config.keltnerPullbackShift+(config.keltnerPullbackMaPeriod*i),
                         config.keltnerPullbackMinimumTpSlDistance,
                         config.keltnerPullbackAtrColor));
      this.signalSet.Add(
                         new MovingAveragePullback(
                         config.keltnerPullbackMaPeriod,
                         config.keltnerPullbackTimeframe,
                         config.keltnerPullbackMaMethod,
                         config.keltnerPullbackMaAppliedPrice,
                         config.keltnerPullbackMaShift,
                         config.keltnerPullbackShift+(config.keltnerPullbackMaPeriod*i),
                         config.keltnerPullbackMaColor));
     }
   this.Initialize();
  }
//+------------------------------------------------------------------+
