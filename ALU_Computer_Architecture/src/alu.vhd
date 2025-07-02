library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

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
        variable base, exp, powResult : integer;
        variable logVal : integer;
        variable temp : integer;
    begin
        base := to_integer(signed(A));
        exp  := to_integer(unsigned(B));
        powResult := 1;
        tempResult := (others => '0');
        logVal := 0;
        temp := base;

        case Operation is
            when "000" =>  -- Addition
                tempResult := resize(signed(A), 16) + resize(signed(B), 16);

            when "001" =>  -- Subtraction
                tempResult := resize(signed(A), 16) - resize(signed(B), 16);

            when "010" =>  -- Multiplication
                tempResult := signed(A) * signed(B);

            when "011" =>  -- Power (A ** B)
                if exp >= 0 and exp <= 7 then
                    for i in 1 to exp loop
                        powResult := powResult * base;
                    end loop;
                    tempResult := to_signed(powResult, 16);
                else
                    tempResult := (others => '0');
                end if;

            when "100" =>  -- Bitwise AND
                tempResult := resize(signed(A and B), 16);

            when "101" =>  -- Bitwise OR
                tempResult := resize(signed(A or B), 16);

            when "110" =>  -- SQRT
                if base >= 0 then
                    tempResult := to_signed(integer(sqrt(real(base))), 16);
                else
                    tempResult := (others => '0');
                end if;

            when "111" =>  -- LOG2
                if base > 0 then
                    while temp > 1 loop
                        temp := temp / 2;
                        logVal := logVal + 1;
                    end loop;
                    tempResult := to_signed(logVal, 16);
                else
                    tempResult := (others => '0');
                end if;

            when others =>
                tempResult := (others => '0');
        end case;

        Result <= std_logic_vector(tempResult(7 downto 0));
    end process;
end architecture;

