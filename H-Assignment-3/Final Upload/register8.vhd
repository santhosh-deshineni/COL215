library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY register8 IS
PORT(inp : in std_logic_vector(7 DOWNTO 0);
we : IN STD_LOGIC;
re : in std_logic;
clk : IN STD_LOGIC;
q : OUT std_logic_vector(7 DOWNTO 0));
END register8;

ARCHITECTURE description OF register8 IS

signal store : std_logic_vector(7 downto 0) := "00000000";

BEGIN

process(clk)
begin
if rising_edge(clk) then
if re = '1'then
q <= store;
elsif we = '1' then
store <= inp;
end if;
end if;
end process;
END description;