%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 	BER (for simulation and emulation) calculations
%%
%%	Autor: Sergio Armas-Jimenez
%%	Related to the paper: A DFTs-OFDM Implementation based onGNU-Radio and USRP for Educational Purpose
%%
%clc
fclose all;
%% BER calculation (for both, simulation and emulation)
data0=fopen('data_tx.dat');	%% instruction to open the .dat file in which the data of the sent file was saved
data_tx=fread(data0);		%% reading the previously opened file	
tot_bit_tx=3839840;			%% Set the total value of bits received when the AWGN period is zero. 
							%% The total number of bytes received can vary on each pc, even under 
							%% perfect conditions. Ideally the size should be equal to the number 
							%% of bytes transmitted, but this is not the case. tot_bit_tx = bytes_rx * 8

data1=fopen('data_rx.bmp');	%% instruction to open the .dat file in which the data of the received file was saved
data_rx=fread(data1);		%% reading the previously opened file
%% data_rx=data_rx(5:end);     %% enabled when the convolutional encoder is used to avoid considering the 4 zeros (32 0bits) that the convolutional decoder generates in the receiver.
data_tx1=data_tx(1:length(data_rx));  %%% Cut in length the amount of data transmitted to equal the size of the received data

data_tx_bin=dec2bin(data_tx1);	%%  decimal to binary type conversion for BER calculation, for tx data
data_rx_bin=dec2bin(data_rx);	%%  decimal to binary type conversion for BER calculation, for rx data

errores=size(find(data_tx_bin-data_rx_bin))					%% amount of erroneous data in the receiver
error=(tot_bit_tx(1)-numel(data_rx_bin))+errores;
ber=error/tot_bit_tx(1); %numel(data_rx_bin);				%% BER calculation
ber=ber(1)  												%% BER print on screen




