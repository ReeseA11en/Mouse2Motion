%% Running code

captureMouseMovement

%% Detects Mouse Location; Uses the computer screen for position 

function captureMouseMovement
    % Finding the current date
    d = datetime;
    % Finding the current hour, minute, second, and milliseconds
    [h,m,s] = hms(datetime);
    % Creating the computer's pixel to inch conversion factor (tuned to
    % Logitech G Pro X Superlight Gaming Mouse at a Mouse Speed of 10)
    in_to_px = 908;
    
    % Finding the screen size
    screenSize = get(0,'screensize');
    % Finding the monitor display width (in pixels)
    horiz_limit = screenSize(3)*2-5;
    % Finding the monitor display height (in pixels)
    vert_limit = screenSize(4)*2-5;

    % Initialize an empty array to store mouse positions and timestamps
    mouseDeltaX = [];
    mouseDeltaY = [];
    mouseTime = [];
    
    % Create a Robot object to get mouse position
    robot = java.awt.Robot;
    
    % Start the timer
    tic;

    % Setting a time incrementing variable to set measurement timing
    increm = 0;

    mousePoint = java.awt.MouseInfo.getPointerInfo().getLocation();
    x1 = mousePoint.getX();
    y1 = mousePoint.getY();
    
    % Capture mouse position for a specified duration or until a condition is met
    captureDuration = 50; % seconds
    while toc < captureDuration
        % Get the current mouse position
        mousePoint = java.awt.MouseInfo.getPointerInfo().getLocation();
        x2 = mousePoint.getX();
        y2 = mousePoint.getY();

        % Calculating distance travelled should happen before looping

        delta_x = x2-x1;
        delta_y = y2-y1;
        
        % Get the mouse to loop around after reaching a screen border
        if x2 < 3
            robot.mouseMove(horiz_limit-15, y2);
        elseif x2 > horiz_limit
            robot.mouseMove(60, y2);
        elseif y2 < 3
            robot.mouseMove(x2, vert_limit-15);
        elseif y2 > vert_limit
            robot.mouseMove(x2, 60);
        % Note: This action is pointless, only exiting the if statement
        else
            c = 1;
        end

        % mouseDeltaX(end+1) = delta_x;
        % mouseDeltaY(end+1) = delta_y;

        mouseDeltaX(end+1) = delta_x/in_to_px;
        mouseDeltaY(end+1) = delta_y/in_to_px;


        % Adjusting the reference point to measure movement after looping
        mousePoint = java.awt.MouseInfo.getPointerInfo().getLocation();
        x1 = mousePoint.getX();
        y1 = mousePoint.getY();
        
        % Record the current time
        currentTime = toc;
        
        % Storing the time point of reference
        mouseTime(end+1) = toc;

        % Store the mouse position and time
        %mouseData = [mouseData; x, y, currentTime];
        
        % Display the mouse position and time
        fprintf('Mouse motion: X = %.1f, Y = %.1f, Time = %.3f seconds\n', delta_x, delta_y, currentTime);
        % fprintf('Mouse position: X = %.1f, Y = %.1f, Time = %.3f seconds\n', x1, y1, currentTime);

        % Creating a plot of motion

        % Testing hte number of measurements taken (only want to show most recent 50 measurements)
        if length(mouseDeltaX) < 51
            % PLotting the points
            plot(mouseTime,mouseDeltaX)
            % Formatting and display
            ylim([-2 2])
            title('Mouse Motion')
            drawnow
        else
            % Plotting the points
            plot(mouseTime(end-50:end),mouseDeltaX(end-50:end))
            % Formatting and display
            ylim([-2 2])
            title('Mouse Motion')
            drawnow
        end

        % Pause to control the polling rate
        while toc < increm
            pause(0.0001)
        end
        % Incrementing the reference time variable
        increm = increm + 0.1;
    end

    % Creating an array from the datetime output
    date = char(d);
    % Using the starting time of the function to name the output file
    filename = string(date(1:11)) + ' ' + string(h) + '_' + string(m) + '_' + string(s) + ' MousePosition1.xlsx';

    % Save the collected data to a file
    data = [mouseTime;mouseDeltaX;mouseDeltaY]';
    %column_headers = ['Time','Delta_X(in)','Delta_Y(in)'];
    writematrix('Time',filename,'Sheet',1,'Range','A1')
    writematrix('Delta_X(in)',filename,'Sheet',1,'Range','B1')
    writematrix('Delta_Y(in)',filename,'Sheet',1,'Range','C1')
    %writematrix(data,filename,'WriteMode','append')
    writematrix(data,filename,'Sheet',1,'Range','A2')
    % append('A2:E',string(length(mouseTime)+1))
end

