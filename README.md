# Sensors Display

This software is separated in two distinct repositories :
- [Sensors](./Sensors) : **[STM32 L475E-IOT01A2](https://www.st.com/en/evaluation-tools/b-l475e-iot01a.html)** Source code
- [SensorsDisplay](./SensorsDisplay) : **[Processing 3](https://processing.org/download/)** Source code


# How to use this code
- First you will need to flash [Sensors.hex](Sensors/EWARM/Sensors/Exe/Sensors.hex) into your IOT01A2 board. You can use [STM32CubeProg](https://www.st.com/en/development-tools/stm32cubeprog.html) to do so.
- Now run [SensorsDisplay.pde](SensorsDisplay/SensorsDisplay.pde) using [Processing 3](https://processing.org/download/).


# Troubleshooting
## Device not responding
Change the array position of the ```Serial.list()[0]``` setup line in the [SensorsDisplay.pde](SensorsDisplay/SensorsDisplay.pde) file.
```C++
//Telemetry Initialization
if(Serial.list().length!=0)
{
  deviceCOM = new Serial(this, Serial.list()[0], 115200);
  deviceCOM.clear();
  deviceCOM.bufferUntil(10);
}
```

## Screen not responding
Change ```fullScreen(P3D,2);``` second parameter in the [SensorsDisplay.pde](SensorsDisplay/SensorsDisplay.pde) file.
Try 1 to _Number of Screen_ plugged to the machine.
```C++
//Screen Initialization
fullScreen(P3D,2);
noStroke();
frameRate(30);
```
