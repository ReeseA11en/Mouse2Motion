# Mouse2Motion

## Project Description

Designed for use in a floating ball treadmill for mice, this project creates a low-cost, precise motion tracking tool using a wireless computer mouse. System code was written in MATLAB to ensure readability and accessibility in a typical lab environment, and a Logitech G Pro Superlight Gaming Mouse was used to increase the system's sampling rate and precision.

Throuhgout the project, a number of challenges led to a more felxible, capable result. After failing to access the mouse displacement data directly (using code in C), the mouse position was found using the on-screen cursor position. Limiting position recordings to only one device, cursor positioning created a stopping point when the cursor encountered the edge of the monitor/display screen. To restore the lost data, a boundary was made to frame the monitor and loop the cursor around after reaching an edge. Additionally, a hard coded measurement window was automated to fit the user's display.

Moving forward, this project cold be improved by removing the pixel-to-inch conversion factor (found experiemntally using the Logitech mouse; relies on the mouse's dots per inch precision and the sensitivity seettings of the local device). Automated setting configurations would make this tool universally capable.

## Table of Contents

* How to Access, Install, and Run the Project
* How to Contribute
* Tests and Outcomes

## How to Access, Install, and Run the Project

To access the project, [download MATLAB](https://www.mathworks.com/help/install/ug/install-products-with-internet-connection.html) (the 2024 version was used to develop code) and open the repository's .m file. After tuning the pixel-to-inch conversion factor (experimentally determined using the commented pixel display lines and a physical measuring scale) and setting the length of the recording window, run the first command to execute the code. 

## How to Contribute

To contribute to the work, fork off the existing repository or email rla00009@mix.wvu.edu with questions, comments, or recommendations.

## Tests and Outcomes

The results of this work will be publised in an upcoming publication.
