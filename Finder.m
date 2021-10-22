function [segment, RMS_value, STD_value, Entropy_value] = BME772ProjectFinder(Entropy, RMS, STD)


[RMS_value,segment] = min(RMS);

disp_rms=['Min RMS Value: ', num2str(RMS_value),' At segment ', num2str(segment)];
disp(disp_rms);
disp([' ']);

[STD_value,segment] = min(STD);

disp_std=['Min STD Value: ', num2str(STD_value),' At segment ', num2str(segment)];
disp(disp_std);
disp([' ']);

[Entropy_value,segment] = min(Entropy);

disp_ent=['Min Entropy Value: ', num2str(Entropy_value),' At segment ', num2str(segment)];
disp(disp_ent);
disp([' ']);







