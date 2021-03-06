//+------------------------------------------------------------------+
//|                                                        Puppy.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict
#include <Signals\LastCloseFollowsPrice.mqh>
#include <EA\PortfolioManagerBasedBot\BasePortfolioManagerBot.mqh>
#include <EA\Puppy\PuppyConfig.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Puppy : public BasePortfolioManagerBot
  {
public:
   void              Puppy(PuppyConfig &config);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Puppy::Puppy(PuppyConfig &config):BasePortfolioManagerBot(config)
  {
   this.signalSet.Add(new LastCloseFollowsPrice(
                      config.lcfpPeriod,
                      config.lcfpTimeframe,
                      config.lcfpMinimumTpSlDistance,
                      config.lcfpInvertedSignal,
                      config.lcfpSkew));
   this.Initialize();
  }
//+------------------------------------------------------------------+
