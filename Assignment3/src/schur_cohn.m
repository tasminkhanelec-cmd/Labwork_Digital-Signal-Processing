function s=schur_cohn(Am) 
Am = Am / Am(1); %normalizing 
stable = 1; 
for i=1:length(Am)-1 
Bm = flip(Am); 
Km = Am(end); 
if abs(Km)>=1 %unstable 
stable=0; 
break; 
else 
Am = (Am-Km*Bm) / (1-Km^2); 
Am = Am(1:end-1); 
end 
end 
if stable==0 
s='unstable'; 
else  
s='stable'; 
end 
end 