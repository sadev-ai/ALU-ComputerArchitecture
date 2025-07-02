library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        A         : in std_logic_vector(7 downto 0);
        B         : in std_logic_vector(7 downto 0);
        Operation : in std_logic_vector(2 downto 0);
        Result    : out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of ALU is
begin
    process(A, B, Operation)
        variable tempResult : signed(15 downto 0) := (others => '0');
        variable base, exp, pow_result : integer;
    begin
        -- Initialize variables
        base := to_integer(signed(A));
        exp  := to_integer(unsigned(B));
        pow_result := 1;
        tempResult := (others => '0');
        
        case Operation is
            when "000" =>  -- Addition
                tempResult := resize(signed(A), 16) + resize(signed(B), 16);
                
            when "001" =>  -- Subtraction
                tempResult := resize(signed(A), 16) - resize(signed(B), 16);
                
            when "010" =>  -- Multiplication
                tempResult := signed(A) * signed(B);
                
            when "011" =>  -- Power (A ** B)
                if exp >= 0 and exp <= 7 then  -- More reasonable limit for 8-bit
                    for i in 1 to exp loop
                        pow_result := pow_result * base;
                    end loop;
                    tempResult := to_signed(pow_result, 16);
                else
                    tempResult := (others => '0');
                end if;
                
            when "100" =>  -- Bitwise AND
                tempResult := resize(signed(A and B), 16);
                
            when "101" =>  -- Bitwise OR
                tempResult := resize(signed(A or B), 16);
                
            when "110" =>  -- Bitwise XOR
                tempResult := resize(signed(A xor B), 16);
                
            when others =>  -- Default case
                tempResult := (others => '0');
        end case;
        
        -- Return only the lower 8 bits
        Result <= std_logic_vector(tempResult(7 downto 0));
    end process;
end architecture;