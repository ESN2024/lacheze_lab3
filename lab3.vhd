library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity lab3 is port(
	clk , reset : in std_logic;
	scl , sda : inout std_logic;
	bp : in std_logic;
	i2c : out std_logic;
	out7seg0 , out7seg1 , out7seg2 , out7seg3 , out7seg4 , out7seg5 : out std_logic_vector (7 downto 0)
	);
end entity;

architecture arch of lab3 is
	
signal bcd0 , bcd1 , bcd2 , bcd3 , bcd4 , bcd5 : std_logic_vector(3 downto 0);

    component lacheze_lab3_qsys is
        port (
            clk_clk                              : in    std_logic                    := 'X'; -- clk
            opencores_i2c_0_export_0_scl_pad_io  : inout std_logic                    := 'X'; -- scl_pad_io
            opencores_i2c_0_export_0_sda_pad_io  : inout std_logic                    := 'X'; -- sda_pad_io
            pio0_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
            pio1_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
            pio2_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
            pio4_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
            pio5_7seg_external_connection_export : out   std_logic_vector(3 downto 0);        -- export
            piobp_external_connection_export     : in    std_logic                    := 'X'; -- export
            reset_reset_n                        : in    std_logic                    := 'X'; -- reset_n
            pio3_7seg_external_connection_export : out   std_logic_vector(3 downto 0)         -- export
        );
    end component lacheze_lab3_qsys;
	 
	 component bcd_7segment is 
		port (
			bcd: in STD_LOGIC_VECTOR (3 downto 0);
			out7seg : out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component bcd_7segment;

begin

    u0 : component lacheze_lab3_qsys
        port map (
            clk_clk                              => clk,                              --                           clk.clk
            opencores_i2c_0_export_0_scl_pad_io  => scl,  --      opencores_i2c_0_export_0.scl_pad_io
            opencores_i2c_0_export_0_sda_pad_io  => sda,  --                              .sda_pad_io
            pio0_7seg_external_connection_export => bcd0, -- pio0_7seg_external_connection.export
            pio1_7seg_external_connection_export => bcd1, -- pio1_7seg_external_connection.export
            pio2_7seg_external_connection_export => bcd2, -- pio2_7seg_external_connection.export
            pio4_7seg_external_connection_export => bcd4, -- pio4_7seg_external_connection.export
            pio5_7seg_external_connection_export => bcd5, -- pio5_7seg_external_connection.export
            piobp_external_connection_export     => bp,     --     piobp_external_connection.export
            reset_reset_n                        => reset,                        --                         reset.reset_n
            pio3_7seg_external_connection_export => bcd3  -- pio3_7seg_external_connection.export
        );
		  
	u1 : component bcd_7segment 
		port map (
			bcd 			=>		bcd0,
			out7seg 		=>		out7seg0
		);
	u2 : component bcd_7segment 
		port map (
			bcd 			=>		bcd1,
			out7seg 		=>		out7seg1
		);
	u3 : component bcd_7segment 
		port map (
			bcd 			=>		bcd2,
			out7seg 		=>		out7seg2
		);
	u4 : component bcd_7segment 
		port map (
			bcd 			=>		bcd3,
			out7seg 		=>		out7seg3
		);
	u5 : component bcd_7segment 
		port map (
			bcd 			=>		bcd4,
			out7seg 		=>		out7seg4
		);
	u6 : component bcd_7segment 
		port map (
			bcd 			=>		bcd5,
			out7seg 		=>		out7seg5
		);
		i2c <= '1';
		  
end architecture;
