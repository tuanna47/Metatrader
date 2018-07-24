//+------------------------------------------------------------------+
//|                                                 ExtremeBreak.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Common\Comparators.mqh>
#include <Signals\AbstractSignal.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ExtremeBreak : public AbstractSignal
  {
private:
   Comparators       compare;
   double            Low;
   double            High;
   double            Open;
public:
                     ExtremeBreak(int period,ENUM_TIMEFRAMES timeframe,int shift);
   bool              Validate(ValidationResult *v);
   SignalResult     *Analyze(string symbol);
   SignalResult     *Analyze(string symbol, int shift);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ExtremeBreak::ExtremeBreak(int period,ENUM_TIMEFRAMES timeframe,int shift=2)
  {
   this.Period=period;
   this.Timeframe=timeframe;
   this.Shift=shift;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalResult *ExtremeBreak::Analyze(string symbol)
  {
   this.Analyze(symbol,this.Shift);
   return this.Signal;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExtremeBreak::Validate(ValidationResult *v)
  {
   v.Result=true;

   if(!compare.IsNotBelow(this.Period,1))
     {
      v.Result=false;
      v.AddMessage("Period must be 1 or greater.");
     }

   if(!compare.IsNotBelow(this.Shift,0))
     {
      v.Result=false;
      v.AddMessage("Shift must be 0 or greater.");
     }

   return v.Result;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalResult *ExtremeBreak::Analyze(string symbol, int shift)
  {
   this.Signal.Reset();
   this.Low  = iLow(symbol, this.Timeframe, iLowest(symbol,this.Timeframe,MODE_LOW,this.Period,shift));
   this.High = iHigh(symbol, this.Timeframe, iHighest(symbol,this.Timeframe,MODE_HIGH,this.Period,shift));
   this.Open = iOpen(symbol, this.Timeframe, 0);

   MqlTick tick;
   bool gotTick=SymbolInfoTick(symbol,tick);

   if(gotTick)
     {
      if(tick.bid<this.Low)
        {
         this.Signal.isSet=true;
         this.Signal.time=tick.time;
         this.Signal.symbol=symbol;
         this.Signal.orderType=OP_SELL;
         this.Signal.price=tick.bid;
         this.Signal.stopLoss=this.High;
         this.Signal.takeProfit=tick.bid-(this.High-tick.bid);
        }
      if(tick.ask>this.High)
        {
         this.Signal.isSet=true;
         this.Signal.orderType=OP_BUY;
         this.Signal.price=tick.ask;
         this.Signal.symbol=symbol;
         this.Signal.time=tick.time;
         this.Signal.stopLoss=this.Low;
         this.Signal.takeProfit=(tick.ask+(tick.ask-this.Low));
        }
     }
   return this.Signal;
  }
//+------------------------------------------------------------------+
