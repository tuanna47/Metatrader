//+------------------------------------------------------------------+
//|                                             StaticIndicators.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Common\Comparators.mqh>
#include <Common\AdxData.mqh>
#include <Common\PriceRange.mqh>
#include <Candles\CandleMetrics.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class StaticIndicators
  {
public:

   static bool DidPriceTouch(string symbol,int shift,double thresholdPrice,int period,ENUM_TIMEFRAMES timeframe)
     {
      PriceRange lh=StaticIndicators::GetPriceRange(symbol,shift,period,timeframe);
      return Comparators::IsBetween(thresholdPrice,lh.low,lh.high);
     }

   static AdxData GetAdx(string symbol,int shift,ENUM_TIMEFRAMES timeframe,int period,ENUM_APPLIED_PRICE appliedPrice=PRICE_CLOSE)
     {
      AdxData d;
      d.Main=iADX(symbol,timeframe,period,appliedPrice,MODE_MAIN,shift);
      d.PlusDirection=iADX(symbol,timeframe,period,appliedPrice,MODE_PLUSDI,shift);
      d.MinusDirection=iADX(symbol,timeframe,period,appliedPrice,MODE_MINUSDI,shift);
      return d;
     }

   static double GetAtr(string symbol,int shift,int period,ENUM_TIMEFRAMES timeframe)
     {
      return iATR(symbol,timeframe,period,shift);
     }

   static int GetBarsInHistoryCount(string symbol,ENUM_TIMEFRAMES timeframe)
     {
      return Bars(symbol,timeframe);
     }

   static int GetBarsInHistoryCount(string symbol,ENUM_TIMEFRAMES timeframe,datetime startOn,datetime endOn)
     {
      return Bars(symbol,timeframe,startOn,endOn);
     }

   static int GetBarsOnChartCount(string symbol,ENUM_TIMEFRAMES timeframe)
     {
      return iBars(symbol,timeframe);
     }

   static PriceRange GetBollingerBands(string symbol,int shift,double deviation,int bbShift,ENUM_APPLIED_PRICE appliedPrice,ENUM_TIMEFRAMES timeframe,int period)
     {
      PriceRange pr;
      pr.high=iBands(symbol,timeframe,period,deviation,bbShift,appliedPrice,MODE_UPPER,shift);
      pr.mid=iBands(symbol,timeframe,period,deviation,bbShift,appliedPrice,MODE_MAIN,shift);
      pr.low=iBands(symbol,timeframe,period,deviation,bbShift,appliedPrice,MODE_LOWER,shift);
      return pr;
     }

   static CandleMetrics *GetCandleMetrics(string symbol,int shift,ENUM_TIMEFRAMES timeframe)
     {
      return (new CandleMetrics(symbol,timeframe,shift));
     }

   static double GetHighPrice(string symbol,int shift,ENUM_TIMEFRAMES timeframe)
     {
      return iHigh(symbol,timeframe,shift);
     }

   static double GetHighestPriceInRange(string symbol,int shift,int period,ENUM_TIMEFRAMES timeframe)
     {
      int idx=StaticIndicators::GetIndexOfHighest(symbol,shift,MODE_HIGH,timeframe,period);
      return StaticIndicators::GetHighPrice(symbol,idx,timeframe);
     }

   static int GetIndexOfHighest(string symbol,int shift,ENUM_SERIESMODE mode,ENUM_TIMEFRAMES timeframe,int period)
     {
      return iHighest(symbol,timeframe,mode,period,shift);
     }

   static int GetIndexOfLowest(string symbol,int shift,ENUM_SERIESMODE mode,ENUM_TIMEFRAMES timeframe,int period)
     {
      return iLowest(symbol,timeframe,mode,period,shift);
     }

   static double GetLowestPriceInRange(string symbol,int shift,int period,ENUM_TIMEFRAMES timeframe)
     {
      int idx=StaticIndicators::GetIndexOfLowest(symbol,shift,MODE_LOW,timeframe,period);
      return StaticIndicators::GetLowPrice(symbol,idx,timeframe);
     }

   static double GetLowPrice(string symbol,int shift,ENUM_TIMEFRAMES timeframe)
     {
      return iLow(symbol,timeframe,shift);
     }

   static double GetMovingAverage(string symbol,int shift,int maShift,ENUM_MA_METHOD maMethod,ENUM_APPLIED_PRICE maAppliedPrice,ENUM_TIMEFRAMES timeframe,int period)
     {
      return iMA(symbol,timeframe,period,maShift,maMethod,maAppliedPrice,shift);
     }

   static PriceRange GetPriceRange(string symbol,int shift,int period,ENUM_TIMEFRAMES timeframe)
     {
      PriceRange pr;
      pr.low=StaticIndicators::GetLowestPriceInRange(symbol,shift,period,timeframe);
      pr.high=StaticIndicators::GetHighestPriceInRange(symbol,shift,period,timeframe);
      pr.mid=((pr.low+pr.high)/2);
      return pr;
     }

   static double GetRsi(string symbol,int shift,ENUM_TIMEFRAMES timeframe,int period,ENUM_APPLIED_PRICE appliedPrice=PRICE_CLOSE)
     {
      return iRSI(symbol,timeframe,period,appliedPrice,shift);
     }

   static datetime GetDatetimeAt(string symbol,ENUM_TIMEFRAMES timeframe,int shift)
     {
      return iTime(symbol,timeframe,shift);
     }
  };
//+------------------------------------------------------------------+
