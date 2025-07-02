library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ALU is
    port (
        A      : in std_logic_vector(7 downto 0);  -- 8 bits
        B      : in std_logic_vector(7 downto 0);  -- 8 bits
        Operation    : in std_logic_vector(2 downto 0);	--3 bits
        Result : out std_logic_vector(7 downto 0)	-- 8 bits
    );
end entity;

architecture Behavioral of ALU is
begin
process(A, B, Operation)
    variable tempResult : signed(7 downto 0);
begin	 
	    case Operation is
        when "000" =>  -- Addition
            tempResult := signed(A) + signed(B);
        when "001" =>  -- Subtraction
            tempResult := signed(A) - signed(B);
        when others =>
            tempResult := (others => '0');
    end case;											 
	Result <= std_logic_vector(tempResult);
end process;
end architecture;


