library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_tb is
end entity;

architecture sim of ALU_tb is

    -- Component Declaration
    component ALU is
        port (
            A         : in std_logic_vector(7 downto 0);
            B         : in std_logic_vector(7 downto 0);
            Operation : in std_logic_vector(2 downto 0);
            Result    : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for connecting to ALU
    signal A, B       : std_logic_vector(7 downto 0);
    signal Operation  : std_logic_vector(2 downto 0);
    signal Result     : std_logic_vector(7 downto 0);

begin

    -- Instantiate the ALU
    UUT: ALU
        port map (
            A => A,
            B => B,
            Operation => Operation,
            Result => Result
        );

    -- Stimulus process
    stim_proc: process
    begin
-- Test 1: A = 5, B = 3, Operation = "000" (Addition)
A <= "00000101";  -- 5
B <= "00000011";  -- 3
Operation <= "000";
wait for 10 ns;

-- Test 2: A = 5, B = 3, Operation = "001" (Subtraction)
Operation <= "001";
wait for 10 ns;

-- Test 3: A = 10, B = 20, Operation = "000" (Addition)
A <= "00001010";  -- 10
B <= "00010100";  -- 20
Operation <= "000";  -- ? ÇÖÇÝå ÔÏå
wait for 10 ns;
        wait;
    end process;

end architecture;
