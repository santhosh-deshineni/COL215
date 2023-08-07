library IEEE;
use IEEE.std_logic_1164.all;

entity stopwatch is
Port ( start: in STD_LOGIC;
pause: in STD_LOGIC;
continue : in STD_LOGIC;
reset : in STD_LOGIC;
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
depo : out STD_LOGIC);
end stopwatch;

architecture Behavioral of stopwatch is

signal p,q,r,s,s0,s1:STD_LOGIC;
signal clock_count : natural range 0 to 10000000 := 0;
signal switch_count : natural range 0 to 9 := 0;
signal second1 : natural range 0 to 5 :=0;
signal second2 :natural range 0 to 9 :=0;
signal mincount :natural range 0 to 9 :=0;
signal i : std_logic_vector (15 downto 0);
signal clockcount : natural range 0 to 400000 := 0;
signal switchcount : natural range 0 to 3  := 0;

signal enable_watch : std_logic := '0';
signal reset_watch : std_logic := '0';

signal reset_orig : std_logic := '0';
signal start_orig : std_logic := '0';
signal cont_orig : std_logic := '0';
signal pause_orig : std_logic := '0';

component BitDisp
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
depo : out STD_LOGIC);
end component;

begin

UUT : BitDisp port map (i => i,clk => clk,a => a,b => b,c => c, d=> d,e=> e, f => f,g => g, an0 => an0, an1 => an1, an2 => an2, an3 => an3,depo => depo);

process(clk)
begin
if rising_edge(clk) then
if start = '1' and start_orig = '0' then
   enable_watch <= '1';
reset_watch <= '0';
start_orig <= '1';
elsif start = '0' and start_orig = '1' then
start_orig <= '0';
elsif pause = '1' and pause_orig = '0' then
enable_watch <= '0';
pause_orig <= '1';
elsif pause = '0' and pause_orig = '1' then
pause_orig <= '0';
elsif continue = '1' and cont_orig = '0' then
enable_watch <= '1';
cont_orig <= '1';
elsif continue = '0' and cont_orig = '1' then
cont_orig <= '0';
elsif reset = '1' and reset_orig = '0' then
enable_watch <= '0';
reset_watch <= '1';
reset_orig <= '1';
elsif reset = '0' and  reset_orig = '1' then
reset_orig <= '0';
end if;

if reset_watch = '0' then
if enable_watch = '1' then
    if clock_count >= 10000000 then
        clock_count <= 0;
        if switch_count >= 9 then
            switch_count <= 0;
            if second2 >=9 then
                second2 <= 0;
                if second1 >=5 then
                    second1 <=0;
                    if mincount >=9 then
                        mincount <= 0;
                    else
                        mincount <= mincount+1;
                    end if;
                else
                    second1 <= second1+1;
                end if;
            else
                second2 <= second2+1;
            end if;
        else
            switch_count <= switch_count + 1;
        end if;
    else
        clock_count <= clock_count + 1;
    end if;
end if;
else
    clock_count <= 0;
    switch_count <= 0;
    second2 <= 0;
    second1 <= 0;
    mincount <= 0;
end if;
end if;
end process;


process(switch_count)
begin
case switch_count is
when 0 => 
i(15 downto 12) <="0000";
when 1 =>
i(15 downto 12) <="1000";
when 2 =>
i(15 downto 12) <="0100";
when 3 =>
i(15 downto 12) <="1100";
when 4 =>
i(15 downto 12) <="0010";
when 5 =>
i(15 downto 12) <="1010";
when 6 =>
i(15 downto 12) <="0110";
when 7 =>
i(15 downto 12) <="1110";
when 8 =>
i(15 downto 12) <="0001";
when 9 =>
i(15 downto 12) <="1001";
end case;
end process;

process(second1)
begin
case second1 is
when 0 =>
i(7 downto 4) <="0000";
when 1 =>
i(7 downto 4) <="1000";
when 2 =>
i(7 downto 4) <="0100";
when 3 =>
i(7 downto 4) <="1100";
when 4 =>
i(7 downto 4) <="0010";
when 5 =>
i(7 downto 4) <="1010";
end case;
end process;

process(second2)
begin
case second2 is
when 0 =>
i(11 downto 8) <="0000";
when 1 =>
i(11 downto 8) <="1000";
when 2 =>
i(11 downto 8) <="0100";
when 3 =>
i(11 downto 8) <="1100";
when 4 =>
i(11 downto 8) <="0010";
when 5 =>
i(11 downto 8) <="1010";
when 6 =>
i(11 downto 8) <="0110";
when 7 =>
i(11 downto 8) <="1110";
when 8 =>
i(11 downto 8) <="0001";
when 9 =>
i(11 downto 8) <="1001";
end case;
end process;

process(mincount)
begin
case mincount is
when 0 =>
i(3 downto 0) <="0000";
when 1 =>
i(3 downto 0) <="1000";
when 2 =>
i(3 downto 0) <="0100";
when 3 =>
i(3 downto 0) <="1100";
when 4 =>
i(3 downto 0) <="0010";
when 5 =>
i(3 downto 0) <="1010";
when 6 =>
i(3 downto 0) <="0110";
when 7 =>
i(3 downto 0) <="1110";
when 8 =>
i(3 downto 0) <="0001";
when 9 =>
i(3 downto 0) <="1001";
end case;
end process;
end Behavioral;