%question i

clc; 
clear all; 
close all; 
fp1 = 50; 
fp2 = 150; 
fp3 = 400; 
fp = [fp3 fp2 fp1]; 
fs = 2000; 
ts = 1/fs; 
n = (0:(120-1))*ts; 
fig_no = 1; 
for N_p=1:fs 
del_p = fs/N_p; 
if(mod(fp1,del_p)==0 && mod(fp2,del_p)==0 && mod(fp3,del_p)==0) 
p = 4*sin(2*pi*fp1*n) + 3*cos(2*pi*fp2*n) + sin(2*pi*fp3*n); 
P = abs(fftshift(fft(p,N_p))); 
w_p = (0:length(P)-1)/(length(P)*ts)-1/(2*ts) ; 
figure(fig_no) 
stem(w_p,P); 
xlabel('Frequency [Hz]'); 
ylabel('|X|');  
title('DFT of p(t)'); 
xlim([0 1000]); 
fig_no = fig_no + 1; 
[peaks_p,locs_p] = findpeaks(P,'Threshold',1); 
for i_p=1:length(peaks_p)/2 
error_p(i_p) = ((abs(w_p(locs_p(i_p)))-fp(i_p))/fp(i_p))*100; 
end 
if max(abs(error_p))<1.5 
break; 
end 
end 
end 
fprintf('The lowest number of DFT points required for p(t) = N_p = %d',N_p); 


%% question ii
clc; 
clear all; 
close all; 
 
fq1 = 150; 
fq2 = 400; 
fq = [fq2 fq1]; 
 
fs = 2000; 
ts = 1/fs; 
n = (0:(120-1))*ts; 
 
fig_no = 1; 
for N_q = 1:fs 
     del_q = fs/N_q; 
      
     if(mod(fq1,del_q)==0 && mod(fq2,del_q)==0 ) 
         q = 3*cos(2*pi*fq1*n) + sin(2*pi*fq2*n); 
         Q = abs(fftshift(fft(q,N_q))); 
         w_q = (0:length(Q)-1)/(length(Q)*ts)-1/(2*ts) ; 
          
         figure(fig_no); 
         stem(w_q,Q); 
         xlabel('Frequency [Hz]'); 
         ylabel('|X|');  
         title('DFT of q(t)'); 
         xlim([0 1000]); 
 
         fig_no = fig_no + 1; 
            
         [peaks_q,locs_q] = findpeaks(Q,'Threshold',1); 
         for i_q=1:length(peaks_q)/2 
               error_q(i_q)=((abs(w_q(locs_q(i_q)))-fq(i_q))/fq(i_q))*100; 
         end 
 
         if max(abs(error_q))<1.5 
             break; 
         end 
     end 
 end 
  
 fprintf('The lowest number of DFT points required for q(t) = N_q = %d',N_q); 