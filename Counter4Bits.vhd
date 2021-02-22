library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Counter4Bits is
	generic(MAX		: natural := 9);
	port(reset		: in  std_logic;
		  clk			: in  std_logic;
		  enable1	: in  std_logic;
		  enable2	: in  std_logic;
		  enable3   : in  std_logic;
		  valOut		: out std_logic_vector(3 downto 0);
		  termCnt	: out std_logic);
end Counter4Bits;

architecture RTL of Counter4Bits is

	signal s_value : unsigned(3 downto 0):= to_unsigned(MAX, 4);

begin
	process(reset, clk)
	begin	
		if (rising_edge(clk)) and (enable3='0') then -- Enable3 representa o Start(SW(1)='0') e Pause(SW(1)='1')
			if (reset = '1') then
				s_value <= to_unsigned(MAX, 4);
				termCnt <= '0';
			elsif ((enable1 = '1') and (enable2 = '1')) then
			-- Valor mínimo dos segundos
				if (to_integer(s_value) = 0) then
					s_value <= to_unsigned(MAX, 4);
					termCnt <= '0';
				else
					s_value <= s_value - 1;
					if (to_integer(s_value) = 1) then
						termCnt <= '1';
					else
						termCnt <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;

	valOut <= std_logic_vector(s_value);
end RTL;
