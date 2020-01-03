//+------------------------------------------------------------------+
//|                                               TrendLineAlert.mq5 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
//hai mark
#property copyright "click here for free cookies"
#property link      "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
#property version   "0.0"
#property indicator_chart_window
#property indicator_plots   0
//--- input parameters
input string TrendLineName = "alertCatalyst";

int OnInit()
  {
   return(0);
  }

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   if(TrendLineName!="")
   {
      double TrendValue = GetTrend(TrendLineName);
      Comment("Trend Line("+TrendLineName+") value = "+DoubleToString(TrendValue,_Digits)); 
      if(TrendValue>0)
      {
         ArraySetAsSeries(close,true);
         ArraySetAsSeries(low,true);
         ArraySetAsSeries(high,true);
         if(close[0]>=TrendValue && low[0]<TrendValue)
         {
            SendNotification("Trendline " + TrendLineName + " tapped on " + Symbol());
         }
         if(close[0]<=TrendValue && high[0]>TrendValue)
         {
            
            SendNotification("Trendline " + TrendLineName + " tapped on " + Symbol());
         }         
      }
   }
   return(rates_total);
}

double GetTrend(string trend_name)
{
   for(int cnt=0; cnt<ObjectsTotal(0); cnt++)
   {
      string objName = ObjectName(0,cnt);
      
      if(StringFind(objName,trend_name)>-1)
      {
         return(ObjectGetValueByTime(0,objName,TimeCurrent()));
      }      
   }
   return(0);
}