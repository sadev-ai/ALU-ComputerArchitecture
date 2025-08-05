library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port(
    A         : in  std_logic_vector(7 downto 0);
    B         : in  std_logic_vector(7 downto 0);
    Operation : in  std_logic_vector(3 downto 0);
    Result    : out std_logic_vector(15 downto 0);
    Carryout  : out std_logic
  );
end entity;

architecture Behavioral of ALU is
begin

  process(A, B, Operation)
    variable base_int   : integer;
    variable exp_int    : integer;
    variable tmp_sum    : unsigned(8 downto 0);
    variable tempResult : signed(15 downto 0);
    variable pow_res    : integer;
    variable i          : integer;
    variable log_res    : integer;
    variable log_tmp    : integer; 
	variable num    : unsigned(7 downto 0);
	variable remm   : unsigned(9 downto 0);  
	variable root   : unsigned(9 downto 0);  
	variable trial  : unsigned(9 downto 0);  

  begin

    tmp_sum  := ('0' & unsigned(A)) + ('0' & unsigned(B));
    Carryout <= tmp_sum(8);

    base_int := to_integer(signed(A));
    exp_int  := to_integer(unsigned(B));

    case Operation is

      when "0000" =>  -- Addition
        tempResult := resize(signed(tmp_sum(7 downto 0)), 16);

      when "0001" =>  -- Subtraction
        tempResult := resize(signed(A), 16) - resize(signed(B), 16);

      when "0010" =>  -- Multiplication
        tempResult := resize(signed(A) * signed(B), 16);

      when "0011" =>  -- Power A^B
        pow_res := 1;
        for i in 1 to exp_int loop
          pow_res := pow_res * base_int;
        end loop;
        tempResult := to_signed(pow_res, 16);

      when "0100" =>  -- Bitwise AND
        tempResult := resize(signed(A and B), 16);

      when "0101" =>  -- Bitwise OR
        tempResult := resize(signed(A or B), 16);

      when "0110" =>  -- Square root
  if base_int >= 0 then
    num   := unsigned(A);
    remm  := (others => '0');
    root  := (others => '0');

    for i in 0 to 3 loop
      root := root sll 1;
      remm := remm sll 2;
      remm(1 downto 0) := num(7 downto 6);
      num := num sll 2;

      trial := (root sll 1) + 1;

      if remm >= trial then
        remm := remm - trial;
        root := root + 1;
      end if;
    end loop;

    tempResult := to_signed(to_integer(root), 16);
  else
    tempResult := (others => '0');
  end if;


      when "0111" =>  -- Logarithm base B
        if base_int > 0 and exp_int > 1 then
          log_res := 0;
          log_tmp := base_int;
          while log_tmp >= exp_int loop
            log_tmp := log_tmp / exp_int;
            log_res := log_res + 1;
          end loop;
          tempResult := to_signed(log_res, 16);
        else
          tempResult := (others => '0');
        end if;

      when "1000" =>  -- Division
        if exp_int /= 0 then
          tempResult := to_signed(base_int / exp_int, 16);
        else
          tempResult := (others => '0');
        end if;

      when "1001" =>  -- Modulo
        if exp_int /= 0 then
          tempResult := to_signed(base_int mod exp_int, 16);
        else
          tempResult := (others => '0');
        end if;

      when others =>
        tempResult := (others => '0');

    end case;

    Result <= std_logic_vector(tempResult);
  end process;

end architecture Behavioral;
