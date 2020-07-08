%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 	SNR for emulation calculation
%%
%%	Autor:Jaime Sanchez-García || Sergio Armas-Jimenez
%%	Related to the paper: A DFTs-OFDM Implementation based onGNU-Radio and USRP for Educational Purpose
%%
%%
%%	Acording to the paper: Blind SNR estimation of OFDM signals
% clc
% fclose all;
symb_rx0=fopen('data_channel.dat');			%% file opening
symb_rx1=fread(symb_rx0, 'float');				%% data reading before being equalized	


data_0=reshape(symb_rx1,[2,length(symb_rx1)/2]);
dat_trans=data_0.';
dat_1=dat_trans(:,2);
dat_2=dat_1*1j;
symb_rx=dat_trans(:,1)+dat_2;


N=512;  				 				%% number of total subcarriers
%N_symbs=size(symb_rx)/N;				%% number of ofdm symbols received
symb=symb_rx(1:(size(symb_rx)/16));  		%Asignacion de los bits recibidos a symb
%
N_symbs=(size(symb_rx)/16)/N;
N_free=444;								%% number of empty subcarriers
eta_avrg=N_free/N;						%% average eta value	Eq. 7																																																																																																																																																																																																																																																																																																															% 512(ifft)-64(dfts)-4(pilotos)

y=0;
yq=0;									%% variable initialization
q_carriers=[1:222, 257, N-220:N ]; 		%% empty subcarriers

%% Eq. 9 numerator 
for i=1:size(symb)	
  y=y+abs(symb(i))^2;
end

%% vector of empty carrier positions creation for all symbols
for jj=1:N_symbs-1
  q_carriers=[q_carriers jj*N+1:jj*N+222, jj*N+257, jj*N+N-220:jj*N+N];
end 

%% Eq. 9 denominator
for ii=1:length(q_carriers)
  yq=yq+abs(symb(q_carriers(ii)))^2;
end

%% Eq. 9
snr=(y/yq)*eta_avrg-1;

%% logarithmic version of Eq. 9
snr_log=10*log10(snr);

%% value obtained screen printing
fprintf('\n.:| snr |:.\n %f \n \n', snr_log)