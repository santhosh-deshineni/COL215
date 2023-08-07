library IEEE;
use IEEE.std_logic_1164.all;
entity BitDisp is
Port ( i : in STD_LOGIC_VECTOR (15 downto 0);
clk : in STD_LOGIC;
a :out STD_LOGIC;
b :out STD_LOGIC;
c :out STD_LOGIC;
d :out STD_LOGIC;
e :out STD_LOGIC;
f :out STD_LOGIC;
g :out STD_LOGIC;
an0 : out STD_LOGIC;
an1 : out STD_LOGIC;
an2 : out STD_LOGIC;
an3 : out STD_LOGIC;
depo : out std_logic);
end BitDisp;

architecture Behavioral of BitDisp is

signal p,q,r,s,s0,s1:STD_LOGIC;
signal clock_count : natural range 0 to 400000 := 0;
signal switch_count : natural range 0 to 3  := 0;

begin

process(clock_count,switch_count,clk)
begin
if rising_edge(clk) then
    
    if clock_count >= 400000 then
        clock_count <= 0;
        if switch_count >= 3 then
            switch_count <= 0;
        else
            switch_count <= switch_count + 1;
        end if;
    else
        clock_count <= clock_count + 1;
    end if;
end if;
end process;

process(switch_count,s0,s1)
begin
case switch_count is
when 0 =>
s0 <= '0';
s1 <= '0';
when 1 =>
s0 <= '0';
s1 <= '1';
when 2 =>
s0 <= '1';
s1 <= '1';
when 3 =>
s0 <= '1';
s1 <= '0';
end case;
end process;

an0 <= s0 nand s1;
an1 <= not s0 or s1;
an2 <= s0 or not s1;
an3 <= s0 or s1;
depo <= s1;
p <= (not s0 and not s1 and i(0)) or (not s0 and s1 and i(4)) or (s0 and not s1 and i(8)) or (s0 and s1 and i(12));
q <= (not s0 and not s1 and i(1)) or (not s0 and s1 and i(5)) or (s0 and not s1 and i(9)) or (s0 and s1 and i(13));
r <= (not s0 and not s1 and i(2)) or (not s0 and s1 and i(6)) or (s0 and not s1 and i(10)) or (s0 and s1 and i(14));
s <= (not s0 and not s1 and i(3)) or (not s0 and s1 and i(7)) or (s0 and not s1 and i(11)) or (s0 and s1 and i(15));

a <= (not p and not r and (q xor s)) or ( p and s and (q xor r));
b <= (q and not s and (p or r)) or (s and ((p and r) or (not p and q and not r)));
c <= (p and q and (r or not s)) or (not p and not q and r and not s);
d <= (not p and not r and (q xor s)) or (r and (( q and s) or (p and not q and not s)));
e <= (not r and ((not p and q)or ( not q and s))) or (not p and s);
f <= (p and q and not r and s) or (not p and (( r and s) or ( not q and (r or s))));
g <= (q and ((p and not r and not s) or (not p and r and s))) or (not p and not q and not r);

end Behavioral;
