
module lacheze_lab3_qsys (
	clk_clk,
	opencores_i2c_0_export_0_scl_pad_io,
	opencores_i2c_0_export_0_sda_pad_io,
	pio0_7seg_external_connection_export,
	pio1_7seg_external_connection_export,
	pio2_7seg_external_connection_export,
	pio3_7seg_external_connection_export,
	pio4_7seg_external_connection_export,
	pio5_7seg_external_connection_export,
	piobp_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	inout		opencores_i2c_0_export_0_scl_pad_io;
	inout		opencores_i2c_0_export_0_sda_pad_io;
	output	[3:0]	pio0_7seg_external_connection_export;
	output	[3:0]	pio1_7seg_external_connection_export;
	output	[3:0]	pio2_7seg_external_connection_export;
	output	[3:0]	pio3_7seg_external_connection_export;
	output	[3:0]	pio4_7seg_external_connection_export;
	output	[3:0]	pio5_7seg_external_connection_export;
	input		piobp_external_connection_export;
	input		reset_reset_n;
endmodule
