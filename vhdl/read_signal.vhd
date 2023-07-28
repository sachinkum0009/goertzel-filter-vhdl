library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

-- generate the clock signal

entity read_signal is
end read_signal ;

architecture Behavioral of read_signal is
  component goertzel_filter is
      generic (
          coefficient : signed(17 downto 0) := to_signed(19071, 18); -- 10^-4
          size_of_signals : integer := 18
      );
      port (
          input_signal : in unsigned (13 downto 0);
          clk : in std_logic;
          rst : in std_logic;
          magnitude : out signed(39 downto 0)
      );
  end component goertzel_filter;

  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal magnitude : signed(39 downto 0); -- 40 bit as the rectangualar wave magnitude is huge
  signal data_signal : unsigned(13 downto 0);
  constant coefficient_value : signed(17 downto 0) := to_signed(19071, 18);
begin
  DUT: goertzel_filter
  generic map(
    coefficient => coefficient_value
  )
  port map (
    clk => clk, 
    rst => rst, 
    input_signal => data_signal, 
    magnitude => magnitude
  );

  clk_gen: process begin
    clk <= '0';
    wait for 500 ns;
    clk <= '1';
    wait for 500 ns;
  end process;

  process is
    variable line_v : line;
    -- variable 
    file read_file : text;
    variable file_data : unsigned(15 downto 0);

  begin
    file_open(read_file, "signals_rect_ones.txt", read_mode);
    while not endfile(read_file) loop

      readline(read_file, line_v);
      hread(line_v, file_data);
      report "file_data: " & to_hstring(file_data);
      if file_data = 1 then
        rst <= '1';
      else
        rst <= '0';
        data_signal <= resize(file_data, data_signal'length);
      end if;
      wait until rising_edge(clk);
      
    end loop;
      
    file_close(read_file);
    wait;
  end process;
end architecture;
