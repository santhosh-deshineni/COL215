library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Clock is
  Port (s1 : out std_logic := '0';
  s2 : out std_logic := '0';
  clk : in std_logic);
end Clock;

architecture Behavioral of Clock is
signal count1: integer := 0;
signal count2 : integer := 0;
signal a: std_logic := '0';
signal b: std_logic := '0';
begin

process(clk)
begin
if(rising_edge(clk)) then
    if(count1 <= 250000) then
        s1 <= '1';
        s2 <= '1';
        count1 <= count1 + 1;
    elsif(count1 <= 500000) then
         s1 <= '1';
         s2 <= '0';
        count1 <= count1 + 1;
    elsif(count1 <= 750000) then
        s1 <= '0';
        s2 <= '1';
        count1 <= count1 + 1;
     elsif(count1 <= 1000000) then
        s1 <= '0';
        s2 <= '0';
        count1 <= count1 + 1;
     else
        count1 <= 1;
     end if;
 end if;
 end process;

end Behavioral;