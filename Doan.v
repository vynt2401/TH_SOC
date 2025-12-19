module Doan (
    input  CLOCK_50,
    input  [3:0] KEY, // Sửa thành [3:0] cho đúng chuẩn board DE10 (KEY0 là Reset)
    
    // --- CHÚNG TA KHÔNG KHAI BÁO CỔNG SPI Ở ĐÂY NỮA ---
    // Vì ta sẽ dùng cổng GPIO chung bên dưới để map chân
    
    // Cổng GPIO 40 chân (JP1) - Quan trọng cho Cách 2
    inout  [35:0] GPIO, 

    // LED 7 đoạn (HEX0 -> HEX5)
    output wire [6:0] HEX0,
    output wire [6:0] HEX1,
    output wire [6:0] HEX2
    // Nếu bạn muốn dùng thêm HEX3, 4, 5 thì khai báo thêm ở đây
);

    // =============================================================
    // 1. KHAI BÁO DÂY NỐI TRUNG GIAN (WIRES)
    // =============================================================
    wire w_spi_clk;
    wire w_spi_mosi;
    wire w_spi_miso;
    wire w_spi_cs_n;
    
    wire [31:0] led_data; // Dữ liệu từ PIO (Nios) xuất ra

    // =============================================================
    // 2. GỌI HỆ THỐNG QSYS (INSTANTIATE)
    // =============================================================
    system u0 (
        .clk_clk         (CLOCK_50),
        .reset_reset_n   (KEY[0]), // Nhấn KEY0 để Reset
        
        // Nối dây SPI vào các dây trung gian
        .spi_0_MISO      (w_spi_miso),
        .spi_0_MOSI      (w_spi_mosi),
        .spi_0_SCLK      (w_spi_clk),
        .spi_0_SS_n      (w_spi_cs_n),
        
        // Nối dây LED
        .led_7seg_export (led_data) 
    );

    // =============================================================
    // 3. GÁN CHÂN VẬT LÝ (MAPPING) - PHẦN QUAN TRỌNG NHẤT
    // =============================================================
    // Sơ đồ: Cắm hàng dọc bên trái của JP1 (Pin 1, 3, 5, 7)
    
    // Pin 1 (GPIO[0]) -> CLK
    assign GPIO[0] = w_spi_clk;

    // Pin 3 (GPIO[2]) -> MISO (Input)
    // Vì là Input (dữ liệu từ Cảm biến -> FPGA), ta gán ngược lại
    assign w_spi_miso = GPIO[2]; 

    // Pin 5 (GPIO[4]) -> MOSI
    assign GPIO[4] = w_spi_mosi;

    // Pin 7 (GPIO[6]) -> CS (Chip Select)
    assign GPIO[6] = w_spi_cs_n;

    // =============================================================
    // 4. XỬ LÝ LED 7 ĐOẠN
    // =============================================================
    // Gán dữ liệu từ PIO ra các chân HEX thực tế
    assign HEX0 = led_data[6:0];   // Byte thấp nhất
    assign HEX1 = led_data[14:8];  // Byte tiếp theo
    assign HEX2 = led_data[22:16]; // Byte tiếp theo

endmodule