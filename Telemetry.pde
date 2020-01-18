class Measure{
  float value;
  Date date;
  
  Measure(float measure)
  {
    value = measure;
    date = new Date();
  }
  
  void Display()
  {
    date.Display();
    print(" -> "+value);
  }
}

class Date{
  int tick, second, minute, hour, day, month, year;
  
  Date()
  {
    tick = millis();
    second = second();
    minute = minute();
    hour = hour();
    day = day();
    month = month();
    year = year();
  }
  
  void Display()
  {
    print(day+"/"+month+"/"+year+" "+hour+"h"+minute+"m"+second+"s "+tick+"'");
  }
}

void serialEvent(Serial p)
{ 
  RxBuffer = p.readStringUntil(10);//Read until lf
  
  Buffer = match(RxBuffer, "T(.*?)\n");
  if(Buffer != null)
  {
    Temperature.add(new Measure(float(Buffer[1])));
    Buffer = null;
  }
  else
  {
    Buffer = match(RxBuffer, "H(.*?)\n");
    if(Buffer != null)
    {
      Humidity.add(new Measure(float(Buffer[1])));
      Buffer = null;
    }
    else
    {
      Buffer = match(RxBuffer, "P(.*?)\n");
      if(Buffer != null)
      {
        Pressure.add(new Measure(float(Buffer[1])));
        Buffer = null;
      }
      else
      {
        Buffer = match(RxBuffer, "Gx(.*?)\n");
        if(Buffer != null)
        {
          gyroX.add(new Measure(int(Buffer[1])));
          Buffer = null;
        }
        else
        {
          Buffer = match(RxBuffer, "Gy(.*?)\n");
          if(Buffer != null)
          {
            gyroY.add(new Measure(int(Buffer[1])));
            Buffer = null;
          }
          else
          {
            Buffer = match(RxBuffer, "Gz(.*?)\n");
            if(Buffer != null)
            {
              gyroZ.add(new Measure(int(Buffer[1])));
              Buffer = null;
            }
            else
            {
              Buffer = match(RxBuffer, "Ax(.*?)\n");
              if(Buffer != null)
              {
                accX.add(new Measure(int(Buffer[1])));
                Buffer = null;
              }
              else
              {
                Buffer = match(RxBuffer, "Ay(.*?)\n");
                if(Buffer != null)
                {
                  accY.add(new Measure(int(Buffer[1])));
                  Buffer = null;
                }
                else
                {
                  Buffer = match(RxBuffer, "Az(.*?)\n");
                  if(Buffer != null)
                  {
                    accZ.add(new Measure(int(Buffer[1])));
                    Buffer = null;
                  }
                  else print("No valid Data");
                }
              }
            }
          }
        }
      }
    }
  }
}
