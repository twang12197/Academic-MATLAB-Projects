function keycontrol(r)
robocontrol = figure('KeyPressFcn', @keypress, 'KeyReleaseFcn', @keyrelease)
v = .15; % Velocity of the wheel.
v1 = 0; % left wheel
v2 = 0; % right wheel
    function keypress(hObject, eventdata, cb)
       if (strcmp(eventdata.Key, 'uparrow'))
           v1 = v;
           v2 = v;
       
       elseif (strcmp(eventdata.Key, 'downarrow'))
           v1 = -v;
           v2 = -v;
       elseif (strcmp(eventdata.Key, 'leftarrow'))
           v1 = v;
           v2 = -v;
       
       elseif (strcmp(eventdata.Key, 'rightarrow'))
           v1 = -v;
           v2 = v;
       end
       r.setDriveVelocity(v1,v2);
    end

    function keyrelease(hObject, eventdata, cb)
       if (strcmp(eventdata.Key, 'uparrow'))
           v1 = 0;
           v2 = 0;       
       elseif (strcmp(eventdata.Key, 'downarrow'))
           v1 = 0;
           v2 = 0;
       elseif (strcmp(eventdata.Key, 'leftarrow'))
           v1 = 0;
           v2 = 0;
       elseif (strcmp(eventdata.Key, 'rightarrow'))
           v1 = 0;
           v2 = 0;
       end
       r.setDriveVelocity(v1,v2);
    end
end