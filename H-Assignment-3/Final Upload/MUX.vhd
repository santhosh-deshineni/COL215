library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
  Port (an0 : in std_logic_vector(3 downto 0);
  an1 : in std_logic_vector(3 downto 0);
  an2 : in std_logic_vector(3 downto 0);
  an3 : in std_logic_vector(3 downto 0);
  s1 : in std_logic;
  s2 : in std_logic;
  num : out std_logic_vector(3 downto 0);
  an : out std_logic_vector(3 downto 0));
end MUX;

architecture Behavioral of MUX is
begin
process(s1,s2,an0,an1,an2,an3)
begin
if (s1 = '1') then
    if (s2 = '1') then
        num <= an3;
        an <= "0111";
    else
        num <= an2;
        an <= "1011";
    end if;
else
    if (s2 = '1') then
        num <= an1;
        an <= "1101";
    else
        num <= an0;
        an <= "1110";
    end if;
end if;
end process;

end Behavioral;
