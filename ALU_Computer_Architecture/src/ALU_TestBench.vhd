library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity ALU_TB is
end ALU_TB;

architecture Behavioral of ALU_TB is
    component ALU
        port (
            A         : in std_logic_vector(7 downto 0);
            B         : in std_logic_vector(7 downto 0);
            Operation : in std_logic_vector(2 downto 0);
            Result    : out std_logic_vector(7 downto 0)
        );
    end component;

    signal A, B, Result : std_logic_vector(7 downto 0);
    signal Operation : std_logic_vector(2 downto 0);
    signal OperationName : string(1 to 15);

    function to_hex_string(slv: std_logic_vector) return string is
        variable hexlen: integer;
        variable longslv: std_logic_vector(67 downto 0) := (others => '0');
        variable hex: string(1 to 16);
        variable fourbit: std_logic_vector(3 downto 0);
    begin
        hexlen := (slv'length + 3)/4;
        longslv(slv'length-1 downto 0) := slv;
        
        for i in 0 to hexlen-1 loop
            fourbit := longslv(((i*4)+3) downto (i*4));
            case fourbit is
                when "0000" => hex(hexlen-i) := '0';
                when "0001" => hex(hexlen-i) := '1';
                when "0010" => hex(hexlen-i) := '2';
                when "0011" => hex(hexlen-i) := '3';
                when "0100" => hex(hexlen-i) := '4';
                when "0101" => hex(hexlen-i) := '5';
                when "0110" => hex(hexlen-i) := '6';
                when "0111" => hex(hexlen-i) := '7';
                when "1000" => hex(hexlen-i) := '8';
                when "1001" => hex(hexlen-i) := '9';
                when "1010" => hex(hexlen-i) := 'A';
                when "1011" => hex(hexlen-i) := 'B';
                when "1100" => hex(hexlen-i) := 'C';
                when "1101" => hex(hexlen-i) := 'D';
                when "1110" => hex(hexlen-i) := 'E';
                when "1111" => hex(hexlen-i) := 'F';
                when others => hex(hexlen-i) := 'X';
            end case;
        end loop;
        return hex(1 to hexlen);
    end function;
    
begin
    UUT: ALU port map (
        A => A,
        B => B,
        Operation => Operation,
        Result => Result
    );

    process
        variable my_line : line;
    begin
        -- Addition
        Operation <= "000";
        OperationName <= "Addition       ";
        A <= "00000101";  -- 5
        B <= "00000011";  -- 3
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & integer'image(to_integer(signed(A))) &
              string'(" B=") & integer'image(to_integer(signed(B))) &
              string'(" Result=") & integer'image(to_integer(signed(Result))));
        writeline(output, my_line);

        -- Subtraction
        Operation <= "001";
        OperationName <= "Subtraction    ";
        A <= "00001000";  -- 8
        B <= "00000011";  -- 3
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & integer'image(to_integer(signed(A))) &
              string'(" B=") & integer'image(to_integer(signed(B))) &
              string'(" Result=") & integer'image(to_integer(signed(Result))));
        writeline(output, my_line);

        -- Multiplication
        Operation <= "010";
        OperationName <= "Multiplication ";
        A <= "00000101";  -- 5
        B <= "00000011";  -- 3
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & integer'image(to_integer(signed(A))) &
              string'(" B=") & integer'image(to_integer(signed(B))) &
              string'(" Result=") & integer'image(to_integer(signed(Result))));
        writeline(output, my_line);

        -- Power
        Operation <= "011";
        OperationName <= "Power          ";
        A <= "00000010";  -- 2
        B <= "00000011";  -- 3
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & integer'image(to_integer(signed(A))) &
              string'(" B=") & integer'image(to_integer(unsigned(B))) &
              string'(" Result=") & integer'image(to_integer(signed(Result))));
        writeline(output, my_line);

        -- Bitwise AND
        Operation <= "100";
        OperationName <= "AND            ";
        A <= "01010101";
        B <= "00110011";
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & to_hex_string(A) &
              string'(" B=") & to_hex_string(B) &
              string'(" Result=") & to_hex_string(Result));
        writeline(output, my_line);

        -- Bitwise OR
        Operation <= "101";
        OperationName <= "OR             ";
        A <= "01010101";
        B <= "00110011";
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & to_hex_string(A) &
              string'(" B=") & to_hex_string(B) &
              string'(" Result=") & to_hex_string(Result));
        writeline(output, my_line);

        -- SQRT
        Operation <= "110";
        OperationName <= "Square Root    ";
        A <= "01000000";  -- 64
        B <= "00000000";  -- ignored
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & integer'image(to_integer(signed(A))) &
              string'(" Result=") & integer'image(to_integer(signed(Result))));
        writeline(output, my_line);

        -- LOG2
        Operation <= "111";
        OperationName <= "Log2           ";
        A <= "00100000";  -- 32
        B <= "00000000";  -- ignored
        wait for 10 ns;
        write(my_line, string'("Operation: ") & OperationName &
              string'(" A=") & integer'image(to_integer(signed(A))) &
              string'(" Result=") & integer'image(to_integer(signed(Result))));
        writeline(output, my_line);

        wait;
    end process;
end Behavioral;
