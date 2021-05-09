library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity synth_cordic is port(
clk : in std_logic;
resetn : in std_logic;
z : in std_logic_vector(3 downto 0); 
cos_op : out std_logic_vector(17 downto 0); 
sin_op : out std_logic_vector(17 downto 0)); 
end entity synth_cordic;
architecture rtl of synth_cordic is
type signed_array is array (natural range<>) of signed(18 downto 0);
constant tan_array : signed_array(0 to 16):= (to_signed(51471,19),to_signed(30385,19),to_signed(16054,19),to_signed(8149,19),
to_signed(4090,19), to_signed(2047,19),to_signed(1023,19), to_signed(511,19),
to_signed(255,19), to_signed(127,19),to_signed(63,19), to_signed(31,19),
to_signed(15,19),to_signed(7,19),to_signed(3,19),to_signed(1,19), to_signed(0, 19));
signal x_array : signed_array(0 to 15) :=(others => (others =>'0'));
signal y_array : signed_array(0 to 15) :=(others => (others =>'0'));
signal z_array : signed_array(0 to 15) :=(others => (others =>'0'));
signal x_ip: std_logic_vector(17 downto 0):=   "001110110100110111";
signal y_ip: std_logic_vector(17 downto 0):=   "000000000000000000";
signal z_ip: std_logic_vector(17 downto 0):=   "000000000000000000";
signal cos_mag: std_logic_vector(17 downto 0):="000000000000000000";
signal sin_mag: std_logic_vector(17 downto 0):="000000000000000000";
signal cos_c: std_logic_vector(17 downto 0):=  "000000000000000000";
signal sin_c: std_logic_vector(17 downto 0):=  "000000000000000000";
begin
p0: process (z)
begin
case z is 
when "0000" |"1000" |"0100" |"1100" => z_ip <= "000000000000000000";
when "0001" |"1001" |"0111" |"1111" => z_ip <= "000110010010000111";
when "0010" |"1010" |"0110" |"1110" => z_ip <= "001100100100001111" ;
when "0011" |"0101" |"1011" |"1101" => z_ip <= "010010110110010111";
when others => null;
end case;
end process;



p2: process(resetn, clk,z)
begin
if resetn = '0' then
x_array <= (others => (others =>'0'));
z_array <= (others => (others =>'0'));
y_array <= (others => (others =>'0'));
elsif rising_edge(clk) then
if signed(z_ip)< to_signed(0,18)
then
x_array(x_array'low) <=signed(x_ip) + signed('0' & y_ip);
y_array(y_array'low) <=signed(y_ip) - signed('0' & x_ip);
z_array(z_array'low) <=signed(z_ip) + tan_array(0);
else
x_array(x_array'low) <=signed(x_ip) - signed('0' & y_ip);
y_array(y_array'low) <=signed(y_ip) + signed('0' & x_ip);
z_array(z_array'low) <=signed(z_ip) - tan_array(0);
end if;
for i in 1 to 15 loop
if z_array(i-1) < to_signed(0,18)
then
x_array(i) <= x_array(i-1) + (y_array(i-1)/2**i);
y_array(i) <= y_array(i-1) - (x_array(i-1)/2**i);
z_array(i) <= z_array(i-1) + tan_array(i);
else
x_array(i) <= x_array(i-1) - (y_array(i-1)/2**i);
y_array(i) <= y_array(i-1) + (x_array(i-1)/2**i);
z_array(i) <= z_array(i-1) - tan_array(i);
end if;
end loop;
end if;
cos_mag <=std_logic_vector(x_array(x_array'high)(17 downto 0));
sin_mag <=std_logic_vector(y_array(y_array'high)(17 downto 0));
end process;

p3: process(clk,z,cos_mag)
begin
if rising_edge(clk) then
cos_c <=(not cos_mag)+1;
sin_c<= (not sin_mag)+1;

case z is 
when "0000" |"0001" |"0010" |"0011" => cos_op<=cos_mag; sin_op<=sin_mag;
when "0101"|"0110" |"0111" |"1000" => cos_op<=cos_c;sin_op<=sin_mag;
when "1001"|"1010" |"1011" => cos_op<=cos_c;sin_op<=sin_c;
when "1101"|"1110" |"1111"=> cos_op<=cos_mag;sin_op<=sin_c;
when "0100"=> cos_op<=sin_mag; sin_op<=cos_mag;
when "1100"=> cos_op<=sin_c; sin_op<=cos_c;
when others => null;
end case;
end if;
end process;
end architecture rtl;