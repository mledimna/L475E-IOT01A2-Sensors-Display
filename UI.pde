class Chart{
  //Top Right Corner
  float x0, y0;
  
  //Top Left Corner
  float x1, y1;
  
  //Bottom Right Corner
  float x2, y2;
  
  //Bottom Left Corner
  float x3, y3;
  
  int Width, Height, minVal, maxVal;
  
  //Curves Variables
  ArrayList<Measure> Curve1Measures,Curve2Measures,Curve3Measures = null;
  color Curve1Color,Curve2Color,Curve3Color;
  String Curve1Unit,Curve2Unit,Curve3Unit = null;
  
  
  
  String Unit = null;
  
  //Number of Measures to be displayed on the Chart
  int Max_points = 1200;
  /*
    x1 = x Coordinate of Chart's Top Left Corner
    y1 = y Coordinate of Chart's Top Left Corner
    Width = With of Chart
    Height = Height of Chart
    measures = Array List of measures acquired
  */
  Chart(float _x0, float _y0, int _Width, int _Height, int _minVal, int _maxVal)
  {
    //Top Left Corner
    x0 = _x0;

    y0 = _y0;
    
    //Top Right Corner
    x1 = _x0+_Width;
    y1 = _y0;
    
    //Bottom Right Corner
    x2 = _x0+_Width;
    y2 = _y0+_Height;
    
    //Bottom Left Corner
    x3 = _Width;
    y3 = _y0+_Height;
    
    Width = _Width;
    Height = _Height;
    
    minVal = _minVal;
    maxVal = _maxVal;
  }
  
  void Update()
  {
    noStroke();
    fill(73, 73, 73);
    rect(x0, y0, Width, Height, Width/40);
    
    drawCurve(Curve1Color, Curve1Measures, Curve1Unit);
    drawCurve(Curve2Color, Curve2Measures, Curve2Unit);
    drawCurve(Curve3Color, Curve3Measures, Curve3Unit);
    
    stroke(60,60,60);
    strokeWeight(10);
    noFill();
    rect(x0, y0, Width, Height, Width/40);
  }
  
  void Curve1(color _CurveColor, ArrayList<Measure> _CurveMeasures, String _Unit)
  {
    Curve1Color = _CurveColor;
    Curve1Measures = _CurveMeasures;
    Curve1Unit = _Unit;
  }
  
  void Curve2(color _CurveColor, ArrayList<Measure> _CurveMeasures, String _Unit)
  {
    Curve2Color = _CurveColor;
    Curve2Measures = _CurveMeasures;
    Curve2Unit = _Unit;
  }
  
  void Curve3(color _CurveColor, ArrayList<Measure> _CurveMeasures, String _Unit)
  {
    Curve3Color = _CurveColor;
    Curve3Measures = _CurveMeasures;
    Curve3Unit = _Unit;
  }
  
  void drawCurve(color _CurveColor, ArrayList<Measure> _CurveMeasures, String _Unit)
  {
    int nb_points, tStart, tEnd = 0;
    float _x1, _y1, _x2, _y2;
    String dateStart, dateEnd, timeStart, timeEnd;
    
    Measure point1 = null;
    Measure point2 = null;
    Measure pointStart = null;
    Measure pointEnd = null;
    
    if((_CurveMeasures!=null)&&(_CurveMeasures.size()>0))
    {
      nb_points = _CurveMeasures.size();
      
      if(nb_points>=2)
      {
        if(nb_points>Max_points)
        {
          pointStart = _CurveMeasures.get(nb_points-Max_points);
          pointEnd = _CurveMeasures.get(nb_points-1);        
          
          tStart = pointStart.date.tick;
          tEnd = pointEnd.date.tick;
        }
        else
        {
          pointStart = _CurveMeasures.get(0);
          pointEnd = _CurveMeasures.get(nb_points-1);        
          
          tStart = pointStart.date.tick;
          tEnd = pointEnd.date.tick;
        }
        
        //yMin, yMax Text
        textSize(18);
        fill(73,73,73);
        textAlign(LEFT, TOP);
        text(str(maxVal)+_Unit, x0+Width+20, y0);
        textAlign(LEFT, BOTTOM);
        text(str(minVal)+_Unit, x0+Width+20, y0+Height);
                
        //xMin, xMax Text
        textSize(18);
        fill(73,73,73);
        textAlign(LEFT, TOP);
        dateStart = str(pointStart.date.day)+"/"+str(pointStart.date.month)+"/"+str(pointStart.date.year);
        timeStart = str(pointStart.date.hour)+":"+str(pointStart.date.minute)+":"+str(pointStart.date.second);
        text(dateStart+"\n"+timeStart, x0, y0+Height+20);
        textAlign(RIGHT, TOP);
        dateEnd = str(pointEnd.date.day)+"/"+str(pointEnd.date.month)+"/"+str(pointEnd.date.year);
        timeEnd = str(pointEnd.date.hour)+":"+str(pointEnd.date.minute)+":"+str(pointEnd.date.second);
        text(dateEnd+"\n"+timeEnd, x0+Width+20, y0+Height+20);
        
        //Value Line
        point1 = _CurveMeasures.get(nb_points-1);
        _x1 = x1;
        _y1 = int(map(point1.value, minVal, maxVal, y0+Height, y0));
        stroke(0xFFFFFFFF);
        strokeWeight(4);
        line(_x1,_y1,_x1+width/50, _y1);
        
        //Value Text
        textSize(24);
        textAlign(LEFT, BOTTOM);
        fill(0xFFFFFFFF);
        text(str(point1.value)+_Unit, _x1+width/50, _y1);
        
        //Lines
        noFill();
        stroke(_CurveColor);
        strokeWeight(4);
        
        for(int i=0; (i<nb_points-1)&&(i<Max_points); i++)
        {
          point1 = _CurveMeasures.get(nb_points-i-1);
          point2 = _CurveMeasures.get(nb_points-i-2);

          //Right End of Line
          _x1 = map(point1.date.tick, tStart, tEnd, x0, x0+float(Width));
          _y1 = map(point1.value, minVal, maxVal, y0+Height, y0);
          //Left End of Line
          _x2 = map(point2.date.tick, tStart, tEnd, x0, x0+float(Width));
          _y2 = map(point2.value, minVal, maxVal, y0+Height, y0);
          
          line(_x1, _y1, _x2, _y2);
        }
      }
    }
    /*
    else
    {
      textSize(100);
      fill(100, 100, 100);
      textAlign(CENTER, CENTER);
      text("No data", int(x0+(Width/2)), int(y0+(Height/2))); 
    }
    */
  }
}
