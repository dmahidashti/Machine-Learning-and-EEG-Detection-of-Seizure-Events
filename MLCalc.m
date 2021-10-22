function [] = BME772ProjectMLCalc(TP,TN,FP,FN)

accuracy = ((TN+TP)/(TN+TP+FP+FN))*100;
disp(['The accuracy is ', num2str(accuracy),'%']);

sensitivity = ((TP)/(TP+FN))*100;
disp(['The sensitivity is ', num2str(sensitivity),'%']);

specificty = ((TN)/(TN+FP))*100;
disp(['The specificty is ', num2str(specificty),'%']);
