
% Nhiệm vụ 1: Xử lý ảnh và chuyển đổi
close all;
clear all;
clc;

% Đọc ảnh từ file
img = imread('y2025VinhHaLong.jpg');

figure(1);
subplot(2,2,1);
imshow(img);
title('Ảnh gốc');

% Chuyển đổi ảnh thành ma trận uint8
img_double = double(img);
img_uint8 = uint8(img_double);

% Tách kênh màu RGB
R = img_uint8(:,:,1);
G = img_uint8(:,:,2);
B = img_uint8(:,:,3);

% Hiển thị các kênh màu
subplot(2,2,2);
imshow(R);
title('Kênh màu đỏ');

subplot(2,2,3);
imshow(G);
title('Kênh màu xanh lá');

subplot(2,2,4);
imshow(B);
title('Kênh màu xanh dương');

% Nhiệm vụ 2: Mô phỏng hệ thống truyền dẫn số

% Các tham số hệ thống
SNR_dB = [5 8 12]; % Các mức SNR cần kiểm tra
M = 16; % Số mức điều chế cho M-QAM (vì số liền kề là chẵn)
k = log2(M); % Số bit trên một symbol
numBits = numel(img_uint8) * 8; % Tổng số bit cần truyền

% Chuyển đổi ảnh thành chuỗi bit
h1 = waitbar(0, 'Chuyển đổi ảnh thành chuỗi bit...');
bitStream = zeros(1, numBits);
for i = 1:numel(img_uint8)
    temp = dec2bin(img_uint8(i), 8);
    for j = 1:8
        bitStream((i-1)*8 + j) = str2double(temp(j));
    end
    if mod(i, 1000) == 0
        waitbar(i/numel(img_uint8), h1);
    end
end
close(h1);

% Điều chế M-QAM
symbolPeriod = 1; % Tsym
Es = 1; % Năng lượng symbol

% Tạo constellation points cho M-QAM
m = sqrt(M); % M = m^2 cho QAM vuông
[X,Y] = meshgrid(-(m-1):2:m-1, -(m-1):2:m-1);
constellation = complex(X(:), Y(:)).' / sqrt(2*(M-1)/3); % Chuẩn hóa năng lượng

% Điều chế và truyền qua kênh AWGN
figure(2);
h2 = waitbar(0, 'Xử lý điều chế và truyền qua kênh AWGN...');
for snr_idx = 1:length(SNR_dB)
    waitbar((snr_idx-1)/length(SNR_dB), h2, sprintf('Đang xử lý SNR = %d dB...', SNR_dB(snr_idx)));
    SNR = SNR_dB(snr_idx);
    
    % Chia thành nhóm k bits và map sang symbols
    numSymbols = floor(numBits/k);
    symbols = zeros(1, numSymbols);
    
    for i = 1:numSymbols
        % Lấy k bits
        bits = bitStream((i-1)*k + 1 : i*k);
        % Chuyển bits thành chỉ số constellation
        symbol_idx = bin2dec(char(bits + '0')) + 1;
        % Map vào constellation
        symbols(i) = constellation(symbol_idx);
        
        if mod(i, 1000) == 0
            waitbar((snr_idx-1+i/numSymbols)/length(SNR_dB), h2);
        end
    end
    
    % Thêm nhiễu AWGN
    receivedSymbols = awgn(symbols, SNR, 'measured');
    
    % Giải điều chế
    receivedBits = zeros(1, numBits);
    for i = 1:numSymbols
        % Tìm điểm constellation gần nhất
        [~, symbol_idx] = min(abs(receivedSymbols(i) - constellation));
        % Chuyển về bits
        bits = dec2bin(symbol_idx-1, k);
        for j = 1:k
            receivedBits((i-1)*k + j) = str2double(bits(j));
        end
    end
    
    % Chuyển đổi bit stream thành ảnh
    receivedImg = zeros(size(img_uint8));
    for i = 1:numel(receivedImg)
        bits = receivedBits((i-1)*8 + 1 : i*8);
        receivedImg(i) = bin2dec(char(bits + '0'));
    end
    receivedImg = reshape(receivedImg, size(img_uint8));
    
    % Hiển thị kết quả
    subplot(1,3,snr_idx);
    imshow(uint8(receivedImg));
    title(['SNR = ' num2str(SNR) ' dB']);
end
close(h2);

% Tính BER (Bit Error Rate)
figure(3);
ber = zeros(1, length(SNR_dB));

% Tạo và lưu trữ receivedBits cho từng SNR riêng biệt
receivedBits_all = cell(1, length(SNR_dB));

% Tính lại receivedBits cho từng SNR
for snr_idx = 1:length(SNR_dB)
    SNR = SNR_dB(snr_idx);
    
    % Thêm nhiễu AWGN cho SNR hiện tại
    receivedSymbols_snr = awgn(symbols, SNR, 'measured');
    
    % Giải điều chế
    receivedBits_snr = zeros(1, numBits);
    for i = 1:numSymbols
        % Tìm điểm constellation gần nhất
        [~, symbol_idx] = min(abs(receivedSymbols_snr(i) - constellation));
        % Chuyển về bits
        bits = dec2bin(symbol_idx-1, k);
        for j = 1:k
            receivedBits_snr((i-1)*k + j) = str2double(bits(j));
        end
    end
    
    % Lưu giữ receivedBits cho mỗi SNR
    receivedBits_all{snr_idx} = receivedBits_snr;
    
    % Tính BER cho SNR hiện tại
    [~, ber(snr_idx)] = biterr(bitStream, receivedBits_snr);
end

semilogy(SNR_dB, ber, 'b-o');
grid on;
xlabel('SNR (dB)');
ylabel('BER');
title('Bit Error Rate vs SNR');

% Thêm phần vẽ constellation diagram và phân tích phổ
figure(4);
constellation_snr = 8; % Chọn SNR = 8dB để vẽ constellation
idx = find(SNR_dB == constellation_snr);

% Tạo constellation cho tín hiệu gốc
subplot(2,2,1);
symbols_i = real(symbols);
symbols_q = imag(symbols);
scatter(symbols_i(1:1000), symbols_q(1:1000), '.');
grid on;
title('Constellation trước khi qua kênh');
xlabel('In-phase');
ylabel('Quadrature');

% Constellation sau khi qua kênh AWGN
subplot(2,2,2);
received_i = real(receivedSymbols);
received_q = imag(receivedSymbols);
scatter(received_i(1:1000), received_q(1:1000), '.');
grid on;
title(['Constellation sau khi qua kênh (SNR = ' num2str(constellation_snr) ' dB)']);
xlabel('In-phase');
ylabel('Quadrature');

% Vẽ phổ tín hiệu (PSD)
subplot(2,2,3);
Fs = 1/symbolPeriod; % Tần số lấy mẫu
[psd, f] = pwelch(symbols, [], [], [], Fs);
plot(f, 10*log10(psd));
grid on;
title('Phổ tín hiệu trước khi qua kênh');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');

% Vẽ phổ tín hiệu sau khi qua kênh
subplot(2,2,4);
[psd_received, f] = pwelch(receivedSymbols, [], [], [], Fs);
plot(f, 10*log10(psd_received));
grid on;
title(['Phổ tín hiệu sau khi qua kênh (SNR = ' num2str(constellation_snr) ' dB)']);
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');

% Vẽ Eye Diagram
figure(5);

% Tạo eye diagram thủ công
samples_per_symbol = 8; % Số mẫu trên một symbol
num_symbols = 1000; % Số symbol để vẽ
symbols_to_plot = 2; % Số symbol trên một chu kỳ

% Tạo dữ liệu cho eye diagram
data_real = real(receivedSymbols(1:num_symbols));
data_imag = imag(receivedSymbols(1:num_symbols));

% Nội suy để tăng số điểm
t = 1:length(data_real);
t_interp = 1:1/samples_per_symbol:length(data_real);
data_real_interp = interp1(t, data_real, t_interp, 'spline');
data_imag_interp = interp1(t, data_imag, t_interp, 'spline');

% Vẽ eye diagram cho phần thực
subplot(2,1,1);
samples_per_trace = symbols_to_plot * samples_per_symbol;
num_traces = floor(length(data_real_interp)/samples_per_symbol) - symbols_to_plot;

hold on;
for i = 1:num_traces
    start_idx = (i-1)*samples_per_symbol + 1;
    plot(1:samples_per_trace, data_real_interp(start_idx:start_idx+samples_per_trace-1), 'b-', 'LineWidth', 0.5);
end
grid on;
title(['Eye Diagram - Phần thực (SNR = ' num2str(constellation_snr) ' dB)']);
xlabel('Samples');
ylabel('Amplitude');
hold off;

% Vẽ eye diagram cho phần ảo
subplot(2,1,2);
hold on;
for i = 1:num_traces
    start_idx = (i-1)*samples_per_symbol + 1;
    plot(1:samples_per_trace, data_imag_interp(start_idx:start_idx+samples_per_trace-1), 'r-', 'LineWidth', 0.5);
end
grid on;
title(['Eye Diagram - Phần ảo (SNR = ' num2str(constellation_snr) ' dB)']);
xlabel('Samples');
ylabel('Amplitude');
hold off;

% Monte Carlo simulation cho BER
figure(6);
h3 = waitbar(0, 'Đang thực hiện mô phỏng Monte Carlo...');
Eb_N0_dB = -5:2:15; % Dải giá trị Eb/N0
ber_theoretical = zeros(size(Eb_N0_dB));
ber_simulated = zeros(size(Eb_N0_dB));

for i = 1:length(Eb_N0_dB)
    waitbar((i-1)/length(Eb_N0_dB), h3, sprintf('Đang xử lý Eb/N0 = %d dB...', Eb_N0_dB(i)));
    
    % Tính BER lý thuyết cho M-QAM
    Eb_N0 = 10^(Eb_N0_dB(i)/10);
    ber_theoretical(i) = 2*(1-1/sqrt(M))*qfunc(sqrt(3*k*Eb_N0/(M-1)));
    
    % Mô phỏng Monte Carlo
    SNR = Eb_N0_dB(i) + 10*log10(k); % Chuyển đổi Eb/N0 sang SNR
    receivedSymbols_mc = awgn(symbols, SNR, 'measured');
    
    % Giải điều chế
    receivedBits_mc = zeros(1, numBits);
    for j = 1:numSymbols
        bits = dec2bin(round(real(receivedSymbols_mc(j))), k);
        for l = 1:k
            receivedBits_mc((j-1)*k + l) = str2double(bits(l));
        end
    end
    
    [~, ber_simulated(i)] = biterr(bitStream, receivedBits_mc);
    waitbar(i/length(Eb_N0_dB), h3);
end
close(h3);

semilogy(Eb_N0_dB, ber_theoretical, 'r-', 'LineWidth', 2);
hold on;
semilogy(Eb_N0_dB, ber_simulated, 'b*-');
grid on;
legend('BER lý thuyết', 'BER mô phỏng');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs Eb/N0 - So sánh lý thuyết và mô phỏng');

% Vẽ dạng sóng tín hiệu
figure(7);
subplot(2,1,1);
t_signal = (0:length(symbols)-1)*symbolPeriod;
plot(t_signal(1:100), real(symbols(1:100)));
hold on;
plot(t_signal(1:100), imag(symbols(1:100)));
grid on;
title('Dạng sóng tín hiệu sau điều chế');
xlabel('Time');
ylabel('Amplitude');
legend('I', 'Q');

subplot(2,1,2);
plot(t_signal(1:100), real(receivedSymbols(1:100)));
hold on;
plot(t_signal(1:100), imag(receivedSymbols(1:100)));
grid on;
title(['Dạng sóng tín hiệu nhận được (SNR = ' num2str(constellation_snr) ' dB)']);
xlabel('Time');
ylabel('Amplitude');
legend('I', 'Q');