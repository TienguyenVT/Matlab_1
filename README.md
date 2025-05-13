# README

## English Version

### 1. Project Name
Simulation of Digital Communication Systems with Image Transmission

### 2. Project Description
This project is an academic assignment for the "Simulation of Communication Systems" course. Its primary goal is to simulate a complete digital transmission system, focusing on the transmission of an image converted into a binary data stream. We explore how such a system performs under various channel conditions, specifically in the presence of Additive White Gaussian Noise (AWGN).

The simulation is built using MATLAB. The process involves:
* Reading a color image (`y2025VinhHaLong.jpg`).
* Converting this image into a binary bitstream.
* Modulating the bitstream using a digital modulation technique (M-QAM is implemented in the provided code, based on assignment criteria).
* Simulating the transmission of the modulated signal through an AWGN channel at different Signal-to-Noise Ratios (SNRs).
* Demodulating the received signal.
* Reconstructing the image from the demodulated bitstream.
* Evaluating system performance by calculating the Bit Error Rate (BER) and visualizing key signals such as constellation diagrams, signal waveforms, eye diagrams, and power spectral densities.

### 3. Relevant Technologies
* **Programming Language:** MATLAB
* **Key MATLAB Toolboxes/Functions (implied/used):**
    * Image Processing Toolbox (e.g., `imread`, `imshow`, `uint8`, `double`).
    * Communications System related functions (e.g., `awgn` for adding noise, `biterr` for error calculation, `pwelch` for spectral density, `qfunc` for theoretical BER).
    * Basic MATLAB functions for array manipulation, plotting, and creating user interfaces (waitbars).

### 4. User Guide

**Prerequisites:**
* MATLAB installed on your system.
* MATLAB's Image Processing Toolbox. (Communications Toolbox might be beneficial for extending features but the core script uses specific functions or custom logic).
* The image file `y2025VinhHaLong.jpg` must be present in the same directory as the main MATLAB script.

**Running the Simulation:**
1.  Download or clone the project files, including `Assignments_on_Simulation_of_Communication_Systems.m` and `y2025VinhHaLong.jpg`.
2.  Open MATLAB.
3.  Navigate to the directory where you saved the project files.
4.  Run the script `Assignments_on_Simulation_of_Communication_Systems.m` from the MATLAB command window by typing its name and pressing Enter, or by opening it in the editor and clicking the "Run" button.

**Expected Output:**
The script will generate several figures to visualize the simulation results:
* **Figure 1:** Displays the original image and its separated Red, Green, and Blue color channels.
* **Figure 2:** Shows the reconstructed images after transmission over the AWGN channel at the specified SNRs (5, 8, and 12 dB in the code).
* **Figure 3:** Plots the Bit Error Rate (BER) as a function of SNR.
* **Figure 4:**
    * Constellation diagram of the modulated symbols before transmission.
    * Constellation diagram of the received symbols after passing through the AWGN channel (shown for SNR = 8 dB).
    * Power Spectral Density (PSD) of the signal before the channel.
    * PSD of the signal after the channel (shown for SNR = 8 dB).
* **Figure 5:** Eye diagrams for the in-phase and quadrature components of the received signal (shown for SNR = 8 dB).
* **Figure 6:** Compares the simulated BER with the theoretical BER for M-QAM over a range of Eb/N0 values, obtained via Monte Carlo simulation.
* **Figure 7:**
    * Waveform (real and imaginary parts) of the modulated signal (first 100 symbols).
    * Waveform (real and imaginary parts) of the received signal after the AWGN channel (first 100 symbols, shown for SNR = 8 dB).
* Progress of the simulation will be indicated by waitbars for different stages like image to bitstream conversion, SNR loop processing, and Monte Carlo simulation.

### 5. How to Contribute
This project is based on an academic assignment. As such, it is primarily intended for individual student work and assessment.

However, if you have suggestions for:
* Improving the simulation methodology.
* Identifying or fixing bugs in the provided base code.
* Extending the analysis with new features or modulation schemes (for educational exploration).

Please feel free to fork the repository and propose changes. Ensure any contributions or use of this code aligns with academic integrity principles and any specific guidelines from your institution if you are a student.

---

## Phiên bản Tiếng Việt)

### 1. Tên Dự án
Mô phỏng Hệ thống Truyền thông Số với Truyền tải Ảnh

### 2. Mô tả Dự án
Dự án này là một bài tập lớn thuộc môn học "Mô phỏng Hệ thống Truyền thông". Mục tiêu chính là mô phỏng một hệ thống truyền dẫn số hoàn chỉnh, tập trung vào việc truyền tải một hình ảnh đã được chuyển đổi thành dòng bit nhị phân. Chúng tôi khám phá cách hệ thống như vậy hoạt động dưới các điều kiện kênh truyền khác nhau, cụ thể là với sự hiện diện của Nhiễu Gauss Trắng Cộng tính (AWGN).

Mô phỏng được xây dựng bằng MATLAB. Quá trình bao gồm:
* Đọc một ảnh màu (`y2025VinhHaLong.jpg`).
* Chuyển đổi ảnh này thành một chuỗi bit nhị phân.
* Điều chế chuỗi bit bằng kỹ thuật điều chế số (M-QAM được triển khai trong mã nguồn cung cấp, dựa trên tiêu chí của bài tập).
* Mô phỏng việc truyền tín hiệu đã điều chế qua kênh AWGN ở các Tỷ số Tín hiệu trên Nhiễu (SNR) khác nhau.
* Giải điều chế tín hiệu thu được.
* Tái tạo lại hình ảnh từ chuỗi bit đã giải điều chế.
* Đánh giá hiệu năng hệ thống bằng cách tính Tỷ lệ Lỗi Bit (BER) và trực quan hóa các tín hiệu quan trọng như biểu đồ chòm sao, dạng sóng tín hiệu, biểu đồ mắt và mật độ phổ công suất.

### 3. Công nghệ Liên quan
* **Ngôn ngữ lập trình:** MATLAB
* **Các Toolbox/Hàm MATLAB chính (được sử dụng/ngụ ý):**
    * Image Processing Toolbox (ví dụ: `imread`, `imshow`, `uint8`, `double`).
    * Các hàm liên quan đến Hệ thống Truyền thông (ví dụ: `awgn` để thêm nhiễu, `biterr` để tính lỗi bit, `pwelch` cho mật độ phổ, `qfunc` cho BER lý thuyết).
    * Các hàm MATLAB cơ bản để xử lý mảng, vẽ đồ thị và tạo giao diện người dùng (thanh chờ).

### 4. Hướng dẫn Sử dụng

**Yêu cầu:**
* Đã cài đặt MATLAB trên hệ thống của bạn.
* MATLAB's Image Processing Toolbox. (Communications Toolbox có thể hữu ích để mở rộng tính năng nhưng script chính sử dụng các hàm cụ thể hoặc logic tùy chỉnh).
* Tệp ảnh `y2025VinhHaLong.jpg` phải nằm trong cùng thư mục với script MATLAB chính.

**Chạy Mô phỏng:**
1.  Tải xuống hoặc clone các tệp của dự án, bao gồm `Assignments_on_Simulation_of_Communication_Systems.m` và `y2025VinhHaLong.jpg`.
2.  Mở MATLAB.
3.  Di chuyển đến thư mục bạn đã lưu các tệp dự án.
4.  Chạy script `Assignments_on_Simulation_of_Communication_Systems.m` từ cửa sổ lệnh MATLAB bằng cách gõ tên của nó và nhấn Enter, hoặc bằng cách mở nó trong trình soạn thảo và nhấp vào nút "Run".

**Kết quả Dự kiến:**
Script sẽ tạo ra một số cửa sổ đồ thị để trực quan hóa kết quả mô phỏng:
* **Figure 1:** Hiển thị ảnh gốc và các kênh màu Đỏ, Xanh lá, Xanh dương được tách riêng.
* **Figure 2:** Hiển thị các ảnh được tái tạo sau khi truyền qua kênh AWGN ở các mức SNR được chỉ định (5, 8 và 12 dB trong mã nguồn).
* **Figure 3:** Đồ thị Tỷ lệ Lỗi Bit (BER) theo SNR.
* **Figure 4:**
    * Biểu đồ chòm sao của các ký hiệu đã điều chế trước khi truyền.
    * Biểu đồ chòm sao của các ký hiệu nhận được sau khi đi qua kênh AWGN (hiển thị cho SNR = 8 dB).
    * Mật độ Phổ Công suất (PSD) của tín hiệu trước kênh.
    * PSD của tín hiệu sau kênh (hiển thị cho SNR = 8 dB).
* **Figure 5:** Biểu đồ mắt cho thành phần đồng pha và vuông pha của tín hiệu nhận được (hiển thị cho SNR = 8 dB).
* **Figure 6:** So sánh BER mô phỏng với BER lý thuyết cho M-QAM trên một dải giá trị Eb/N0, thu được thông qua mô phỏng Monte Carlo.
* **Figure 7:**
    * Dạng sóng (phần thực và phần ảo) của tín hiệu đã điều chế (100 ký hiệu đầu tiên).
    * Dạng sóng (phần thực và phần ảo) của tín hiệu nhận được sau kênh AWGN (100 ký hiệu đầu tiên, hiển thị cho SNR = 8 dB).
* Tiến trình của mô phỏng sẽ được chỉ báo bằng các thanh chờ cho các giai đoạn khác nhau như chuyển đổi ảnh sang chuỗi bit, xử lý vòng lặp SNR và mô phỏng Monte Carlo.

### 5. Cách Đóng góp
Dự án này dựa trên một bài tập học thuật. Do đó, nó chủ yếu dành cho công việc và đánh giá cá nhân của sinh viên.

Tuy nhiên, nếu bạn có đề xuất để:
* Cải thiện phương pháp mô phỏng.
* Xác định hoặc sửa lỗi trong mã nguồn cơ sở được cung cấp.
* Mở rộng phân tích với các tính năng mới hoặc sơ đồ điều chế (nhằm mục đích khám phá giáo dục).

Vui lòng fork repository và đề xuất thay đổi. Đảm bảo mọi đóng góp hoặc việc sử dụng mã này đều tuân thủ các nguyên tắc về liêm chính học thuật và mọi hướng dẫn cụ thể từ tổ chức của bạn nếu bạn là sinh viên.
