//+------------------------------------------------------------------+
//|                                                      AtrBase.mqh |
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
class AtrBase : public AbstractSignal
  {
protected:
   Comparators       _compare;
   double            _atrMultiplier;
   double            _minimumSpreadsDistance;
public:
                     AtrBase(int period,double atrMultiplier,ENUM_TIMEFRAMES timeframe,int shift=0,double minimumSpreadsTpSl=1,color indicatorColor=clrAquamarine);
   virtual bool      DoesSignalMeetRequirements();
   virtual bool      Validate(ValidationResult *v);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
AtrBase::AtrBase(int period,double atrMultiplier,ENUM_TIMEFRAMES timeframe,int shift=0,double minimumSpreadsTpSl=1,color indicatorColor=clrAquamarine):AbstractSignal(period,timeframe,shift,indicatorColor)
  {
   this._atrMultiplier=atrMultiplier;
   this._minimumSpreadsDistance=minimumSpreadsTpSl;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AtrBase::Validate(ValidationResult *v)
  {
   AbstractSignal::Validate(v);

   if(!this._compare.IsNotBelow((int)this._atrMultiplier,(int)1))
     {
      v.Result=false;
      v.AddMessage("Atr Multiplier must be 1 or greater.");
     }

   if(!this._compare.IsNotBelow((int)this._minimumSpreadsDistance,(int)0))
     {
      v.Result=false;
      v.AddMessage("Minimum spreads distance must be 0 or greater.");
     }

   return v.Result;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AtrBase::DoesSignalMeetRequirements()
  {
   if(!(AbstractSignal::DoesSignalMeetRequirements()))
     {
      return false;
     }

   double point=MarketInfo(this.Signal.symbol,MODE_POINT);
   double minimumPoints=this._minimumSpreadsDistance*MarketInfo(this.Signal.symbol,MODE_SPREAD);

   if((point<=0) || (minimumPoints<0))
     {
      return false;
     }

   if(this.Signal.takeProfit>0)
     {
      if(MathAbs(this.Signal.price-this.Signal.takeProfit)/point<minimumPoints)
        {
         return false;
        }
     }

   if(this.Signal.stopLoss>0)
     {
      if(MathAbs(this.Signal.price-this.Signal.stopLoss)/point<minimumPoints)
        {
         return false;
        }
     }
   return true;
  }
//+------------------------------------------------------------------+
