import processing.serial.*;

//Serial Variables
Serial deviceCOM = null;// Create object from Serial class
String [] Buffer = null;//Sort Data

ArrayList<Measure> Temperature = new ArrayList<Measure>();
ArrayList<Measure> Humidity = new ArrayList<Measure>();
ArrayList<Measure> Pressure = new ArrayList<Measure>();

ArrayList<Measure> gyroX = new ArrayList<Measure>();
ArrayList<Measure> gyroY = new ArrayList<Measure>();
ArrayList<Measure> gyroZ = new ArrayList<Measure>();

ArrayList<Measure> accX = new ArrayList<Measure>();
ArrayList<Measure> accY = new ArrayList<Measure>();
ArrayList<Measure> accZ = new ArrayList<Measure>();

//UI Variables
Chart temperatureChart = null;//Chart Displaying temperature
Chart pressureChart = null;//Chart Displaying pressure
Chart humidityChart = null;//Chart Displaying pressure

Chart gyroChart = null;//Chart Displaying gyro data
Chart accChart = null;//Chart Displaying accelero data

float offset = 50;

//Test Variables
float val = 0;
ArrayList <Measure> testMeasures1 = new ArrayList<Measure>();
ArrayList <Measure> testMeasures2 = new ArrayList<Measure>();
ArrayList <Measure> testMeasures3 = new ArrayList<Measure>();
String RxBuffer = "T31.4H51.65P37.5\n";//Recieved Data

void setup() 
{
  //Telemetry Initialization
  if(Serial.list().length!=0)
  {
    deviceCOM = new Serial(this, Serial.list()[0], 115200);
    deviceCOM.clear();
    deviceCOM.bufferUntil(10);
  }
  
  //Screen Initialization
  fullScreen(P3D,2);
  noStroke();
  frameRate(30);
  
  //UI Initialization
  temperatureChart = new Chart(offset/2, offset/2, int(width/3-offset*2), int(height/3-offset*2), -20, 80);
  pressureChart = new Chart(offset/2, offset/2+height/3, int(width/3-offset*2), int(height/3-offset*2), 0, 2000);
  humidityChart = new Chart(offset/2, offset/2+2*height/3, int(width/3-offset*2), int(height/3-offset*2), 0, 100);
  
  gyroChart = new Chart(width/3+3*offset, offset/2, int(width/2-offset), int(height/2-offset*2), -1000000, 1000000);
  accChart = new Chart(width/3+3*offset, height/2+offset/2, int(width/2-offset), int(height/2-offset*2), -2000, 2000);
}

void draw()
{
  background(color(118, 118, 118));
  
  temperatureChart.Curve1(color(52, 152, 219), Temperature,"°C");
  temperatureChart.Update();
  
  pressureChart.Curve1(color(46, 204, 113), Pressure,"mBars");
  pressureChart.Update();
  
  humidityChart.Curve1(color(231, 76, 60), Humidity,"%");
  humidityChart.Update();
  
  gyroChart.Curve1(color(231, 76, 60), gyroX,"");
  gyroChart.Curve2(color(142, 68, 173), gyroY,"");
  gyroChart.Curve3(color(52, 152, 219), gyroZ,"");
  gyroChart.Update();
  
  accChart.Curve1(color(46, 204, 113), accX,"");
  accChart.Curve2(color(243, 156, 18), accY,"");
  accChart.Curve3(color(211, 84, 0), accZ,"");
  accChart.Update();
  
  /*
  translate(width/2, height/2, 0);
  
  rotateX((accX.get(accX.size()-1)).value/1000);
  rotateY((accY.get(accY.size()-1)).value/1000);
  rotateY((accZ.get(accZ.size()-1)).value/1000);
  
  noFill();
  box(200);
  val += 0.1;
  */
}
