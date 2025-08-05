library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU_TB is
end ALU_TB;

architecture Behavioral of ALU_TB is

  
  signal A, B        : std_logic_vector(7 downto 0) := (others => '0');
  signal Operation   : std_logic_vector(3 downto 0) := (others => '0');
  signal Result      : std_logic_vector(15 downto 0);
  signal OperationName : string(1 to 15);

  component ALU
    port (
      A         : in  std_logic_vector(7 downto 0);
      B         : in  std_logic_vector(7 downto 0);
      Operation : in  std_logic_vector(3 downto 0);
      Result    : out std_logic_vector(15 downto 0)
    );
  end component;

begin

  UUT: ALU
    port map (
      A         => A,
      B         => B,
      Operation => Operation,
      Result    => Result
    );

  stim_proc: process
    
    function to_vec(i : integer) return std_logic_vector is
    begin
      return std_logic_vector(to_signed(i, 16));
    end function;
  begin

    report "===== Starting ALU Testbench =====" severity note;

    -- Test 1: Addition (5 + 3 = 8)
    Operation <= "0000"; OperationName <= "Addition       ";
    A <= "00000101"; B <= "00000011";  wait for 20 ns;
    assert Result = to_vec(8)
      report OperationName & " FAILED: expected  8, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 2: Subtraction (8 - 3 = 5)
    Operation <= "0001"; OperationName <= "Subtraction    ";
    A <= "00001000"; B <= "00000011";  wait for 20 ns;
    assert Result = to_vec(5)
      report OperationName & " FAILED: expected  5, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 3: Multiplication (5 * 3 = 15)
    Operation <= "0010"; OperationName <= "Multiplication ";
    A <= "00000101"; B <= "00000011";  wait for 20 ns;
    assert Result = to_vec(15)
      report OperationName & " FAILED: expected 15, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 4: Power (2^4 = 16)
    Operation <= "0011"; OperationName <= "Power          ";
    A <= "00000010"; B <= "00000100";  wait for 20 ns;
    assert Result = to_vec(16)
      report OperationName & " FAILED: expected 16, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 5: Bitwise AND (0x55 & 0x33 = 0x11 = 17)
    Operation <= "0100"; OperationName <= "AND            ";
    A <= "01010101"; B <= "00110011";  wait for 20 ns;
    assert Result = to_vec(17)
      report OperationName & " FAILED: expected 17, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 6: Bitwise OR (0x55 | 0x33 = 0x77 = 119)
    Operation <= "0101"; OperationName <= "OR             ";
    A <= "01010101"; B <= "00110011";  wait for 20 ns;
    assert Result = to_vec(119)
      report OperationName & " FAILED: expected 119, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 7: Square Root (64 -> 8)
    Operation <= "0110"; OperationName <= "Square Root    ";
    A <= "01000000"; B <= "00000000";  wait for 20 ns;
    assert Result = to_vec(8)
      report OperationName & " FAILED: expected 8, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 8: Log2 (32 -> 5)
    Operation <= "0111"; OperationName <= "Log2           ";
    A <= "00100000"; B <= "00000010";  wait for 20 ns;
    assert Result = to_vec(5)
      report OperationName & " FAILED: expected 5, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 9: Division (20/5 = 4)
    Operation <= "1000"; OperationName <= "Division       ";
    A <= "00010100"; B <= "00000101";  wait for 20 ns;
    assert Result = to_vec(4)
      report OperationName & " FAILED: expected 4, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 10: Modulo (20 mod 6 = 2)
    Operation <= "1001"; OperationName <= "Modulo         ";
    A <= "00010100"; B <= "00000110";  wait for 20 ns;
    assert Result = to_vec(2)
      report OperationName & " FAILED: expected 2, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 11: Log10(100) = 2
    Operation <= "0111"; OperationName <= "Log10          ";
    A <= std_logic_vector(to_signed(100, 8));
    B <= std_logic_vector(to_signed(10, 8));
    wait for 20 ns;
    assert Result = to_vec(2)
      report OperationName & " FAILED: expected 2, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    -- Test 12: Log3(81) = 4
    Operation <= "0111"; OperationName <= "Log3           ";
    A <= std_logic_vector(to_signed(81, 8));
    B <= "00000011";
    wait for 20 ns;
    assert Result = to_vec(4)
      report OperationName & " FAILED: expected 4, got " &
        integer'image(to_integer(signed(Result)))
      severity error;
    report OperationName & " PASSED: result = " &
      integer'image(to_integer(signed(Result))) severity note;

    report "===== ALU Testbench Complete =====" severity note;
    wait;
  end process;

end architecture Behavioral;
