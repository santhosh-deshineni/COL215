library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity MAC is
Port ( re : in std_logic;
we : in std_logic;
clk : in std_logic;
numA : in std_logic_vector(7 downto 0);
numB : in std_logic_vector(7 downto 0);
cntrl : in std_logic;
output : out std_logic_vector(15 downto 0));

end MAC;

architecture Behavioral of MAC is

signal store : std_logic_vector(15 downto 0) := "0000000000000000";

begin
process(clk)
begin
if rising_edge(clk) then
if we = '1' then
if cntrl = '0' then
store <= std_logic_vector(to_unsigned(to_integer(unsigned(numA)) * to_integer(unsigned(numB)) + to_integer(unsigned(store)),16));
else
store <= std_logic_vector(to_unsigned(to_integer(unsigned(numA)) * to_integer(unsigned(numB)),16));
end if;
end if;
if re = '1' then
output <= store;
end if;
end if;
end process;
end Behavioral;