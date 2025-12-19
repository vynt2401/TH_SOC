	component system is
		port (
			clk_clk         : in  std_logic                     := 'X'; -- clk
			led_7seg_export : out std_logic_vector(31 downto 0);        -- export
			reset_reset_n   : in  std_logic                     := 'X'; -- reset_n
			spi_0_MISO      : in  std_logic                     := 'X'; -- MISO
			spi_0_MOSI      : out std_logic;                            -- MOSI
			spi_0_SCLK      : out std_logic;                            -- SCLK
			spi_0_SS_n      : out std_logic                             -- SS_n
		);
	end component system;

	u0 : component system
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			led_7seg_export => CONNECTED_TO_led_7seg_export, -- led_7seg.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --    reset.reset_n
			spi_0_MISO      => CONNECTED_TO_spi_0_MISO,      --    spi_0.MISO
			spi_0_MOSI      => CONNECTED_TO_spi_0_MOSI,      --         .MOSI
			spi_0_SCLK      => CONNECTED_TO_spi_0_SCLK,      --         .SCLK
			spi_0_SS_n      => CONNECTED_TO_spi_0_SS_n       --         .SS_n
		);

