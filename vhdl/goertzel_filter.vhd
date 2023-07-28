library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity goertzel_filter is
    generic (
        coefficient : signed(17 downto 0) := to_signed(19071, 18); -- 10^-4
        coefficient_mul : signed(17 downto 0) := to_signed(10000, 18);
        size_of_signals : integer := 18
    );
    port (
        input_signal : in unsigned (13 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        magnitude : out signed(39 downto 0)
    );
end entity goertzel_filter;

architecture Behavioral of goertzel_filter is
    -- constant size_of_signals : integer := 19;
    constant cosine : signed(size_of_signals - 1 downto 0) := to_signed(951, size_of_signals); -- 10^-3
    constant sine : signed(size_of_signals - 1 downto 0) := to_signed(309, size_of_signals); -- 10^-3
    constant sine_mul : signed(size_of_signals - 1 downto 0) := to_signed(1000, size_of_signals); -- 10^-3
    signal q0_v : signed(size_of_signals - 1 downto 0) := (others => '0');
    signal q1_v : signed(size_of_signals - 1 downto 0) := (others => '0');
    signal q2_v : signed(size_of_signals - 1 downto 0) := (others => '0');
    signal real_part_v : signed(size_of_signals - 1 downto 0) := (others => '0');
    signal img_part_v : signed(size_of_signals - 1 downto 0) := (others => '0');
    
begin
    process (clk, rst)
        variable q0 : signed(size_of_signals - 1 downto 0) := (others => '0');
        variable q1 : signed(size_of_signals - 1 downto 0) := (others => '0');
        variable q2 : signed(size_of_signals - 1 downto 0) := (others => '0');
        variable real_part : signed(size_of_signals - 1 downto 0) := (others => '0');
        variable img_part : signed(size_of_signals - 1 downto 0) := (others => '0');
    begin
        if rst = '1' then
            -- q0 <= (0 => '1', others => '0');
            q0 := (others => '0');
            q1 := (others => '0');
            q2 := (others => '0');

            real_part := (others => '0');
            img_part := (others => '0');

        -- rising edge
        elsif clk'event and clk='1' then
            -- Q0 = coeff * Q1 - Q2 + signal(n);
            q0 := resize(coefficient * q1 / coefficient_mul, q0'length) - q2 + signed("0000" & (input_signal/100));
            -- q0 <= coefficient * q1 - q2 + resize(signed("0" & input_signal), 18);
            -- q0 <= coefficient * q1 - q2 + resize(signed(input_signal), 18);
            
            q2 := q1;
            q1 := q0;
            -- realPart = Q1 - Q2 * cosine;
            -- imagPart = Q2 * sine;
            -- magnitude = sqrt(realPart^2 + imagPart^2);
            real_part := q1 - resize(q2 * cosine / sine_mul, q1'length);
            img_part := resize(q2 * sine / sine_mul, q2'length);
            magnitude <= resize(resize(real_part * real_part, magnitude'length) + resize(img_part * img_part, magnitude'length), magnitude'length);
            report "magnitude: " & to_hstring(magnitude);
            -- report "magnitude: " & to_hstring(magnitude);

            q0_v <= q0;
            q1_v <= q1;
            q2_v <= q2;
            real_part_v <= real_part;
            img_part_v <= img_part;
        end if;
    end process;
    
    
    
end architecture Behavioral;