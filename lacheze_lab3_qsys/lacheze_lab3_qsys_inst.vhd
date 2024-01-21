	component lacheze_lab3_qsys is
		port (
			clk_clk                              : in    std_logic                    := 'X'; -- clk
			opencores_i2c_0_export_0_scl_pad_io  : inout std_logic                    := 'X'; -- scl_pad_io
			opencores_i2c_0_export_0_sda_pad_io  : inout std_logic                    := 'X'; -- sda_pad_io
			pio0_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
			pio1_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
			pio2_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
			pio3_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
			pio4_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
			pio5_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
			piobp_external_connection_export     : in    std_logic                    := 'X'; -- export
			reset_reset_n                        : in    std_logic                    := 'X'  -- reset_n
		);
	end component lacheze_lab3_qsys;

	u0 : component lacheze_lab3_qsys
		port map (
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                           clk.clk
			opencores_i2c_0_export_0_scl_pad_io  => CONNECTED_TO_opencores_i2c_0_export_0_scl_pad_io,  --      opencores_i2c_0_export_0.scl_pad_io
			opencores_i2c_0_export_0_sda_pad_io  => CONNECTED_TO_opencores_i2c_0_export_0_sda_pad_io,  --                              .sda_pad_io
			pio0_7seg_external_connection_export => CONNECTED_TO_pio0_7seg_external_connection_export, -- pio0_7seg_external_connection.export
			pio1_7seg_external_connection_export => CONNECTED_TO_pio1_7seg_external_connection_export, -- pio1_7seg_external_connection.export
			pio2_7seg_external_connection_export => CONNECTED_TO_pio2_7seg_external_connection_export, -- pio2_7seg_external_connection.export
			pio3_7seg_external_connection_export => CONNECTED_TO_pio3_7seg_external_connection_export, -- pio3_7seg_external_connection.export
			pio4_7seg_external_connection_export => CONNECTED_TO_pio4_7seg_external_connection_export, -- pio4_7seg_external_connection.export
			pio5_7seg_external_connection_export => CONNECTED_TO_pio5_7seg_external_connection_export, -- pio5_7seg_external_connection.export
			piobp_external_connection_export     => CONNECTED_TO_piobp_external_connection_export,     --     piobp_external_connection.export
			reset_reset_n                        => CONNECTED_TO_reset_reset_n                         --                         reset.reset_n
		);

