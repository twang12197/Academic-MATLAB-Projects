% Motor-powered Cereal Dispenser Project.
% This code uses the push button to control the motor.
% Shivang Patel, Kevin Beyke, Tao Wang

contorl_time = 3000; % how many time you can put the in and out.
Y= 3.6
 while contorl_time > 0

    voltage = 0; % initalize voltage variable.
    
    while voltage < Y % Intial loop to check if there's a cup
        voltage = readVoltage(a,'A0') % checks if there's a cup
        writeDigitalPin(a,10,1); % LED is red while no cup
    end
    
    writeDigitalPin(a,10,0); % Red Led turns off.
    
    if voltage > Y
        time = 1; % controls the motor while loop.
        writeDigitalPin(a,11,1);% Green Led turns on.
        
        while time > 0
            button_status = readDigitalPin(a,2);% reads if buttons on or off.
            voltage = readVoltage(a,'A0')% checks if cup is in place.

            if button_status == 0 % motors turns if button is pressed
                writeDigitalPin(a,9,1); % turn motor on
                if voltage < Y % if the button is still press after the cup is removed, the motor will stop
                    writeDigitalPin(a,11,0); % Green Led turns off
                    writeDigitalPin(a,10,1); % Red Led turns on
                    button_status = 1; % change the status of the button to off.
                    writeDigitalPin(a,9,0); % turns the motor off
                    time = 0;
                end
            elseif button_status == 1 % motors stops if button isn't pressed
                writeDigitalPin(a,9,0);%turn motor off
            end

            if voltage < Y % the program stops if the cup is removed.
                time = 0; % motors turns off.
                writeDigitalPin(a,11,0); % Green Led turns off
                writeDigitalPin(a,10,1); % Red Led turns on
            end

        end
    end
 contorl_time = contorl_time - 1; % Action minus 1 time.
writeDigitalPin(a,11,0); % Green Led turns off
writeDigitalPin(a,10,0); % Red Led turns off 
 end
        
