
module system (
	clk_clk,
	led_7seg_export,
	reset_reset_n,
	spi_0_MISO,
	spi_0_MOSI,
	spi_0_SCLK,
	spi_0_SS_n);	

	input		clk_clk;
	output	[31:0]	led_7seg_export;
	input		reset_reset_n;
	input		spi_0_MISO;
	output		spi_0_MOSI;
	output		spi_0_SCLK;
	output		spi_0_SS_n;
endmodule
