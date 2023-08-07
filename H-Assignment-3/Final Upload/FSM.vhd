library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.All;
use IEEE.numeric_std.all;

entity FSM is
Port(
    val : in std_logic_vector(15 downto 0);
    clk : in std_logic;
    search : in std_logic_vector(13 downto 0);
    cathode : out std_logic_vector(6 downto 0);
    an : out std_logic_vector(3 downto 0);
    oup : out std_logic_vector(7 downto 0);
    addrA : out std_logic_vector (13 downto 0) :="00000000000000";
    addrB : out std_logic_vector(13 downto 0) := "00000000000000";
    addrC : out std_logic_vector(13 downto 0) :="00000000000000");
end FSM;

architecture behavioral of FSM is

component Display
Port (an0 : in std_logic_vector(3 downto 0);
  an1 : in std_logic_vector(3 downto 0);
  an2 : in std_logic_vector(3 downto 0);
  an3 : in std_logic_vector(3 downto 0);
  clk : in std_logic;
  seg : out std_logic_vector(6 downto 0);
  an : out std_logic_vector(3 downto 0));
end component;

signal count1,count2,count3,count4 : integer := 0;
type state_type is (READ,INPREG,OPREG,MAC,RAM,ENDALL);
signal cur_state : state_type := READ;
signal next_state : state_type := READ;

begin
Disp : Display port map(an0 => val(15 downto 12),an1 => val(11 downto 8),an2 => val(7 downto 4), an3 => val(3 downto 0), clk => clk, seg => cathode,an => an);
process(clk)

begin
if rising_edge(clk) then
cur_state <= next_state;
    if cur_state = MAC then

    if count2 = 127 then
        count3 <= 0;
        count2 <= 0;

        if count4 = 127 then
            count1 <= count1 + 1;
            count4 <= 0;
        else
            count4 <= count4 + 1;
        end if;
    else
        count2 <= count2 + 1;
        count3 <= count3 + 1;
    end if;
    end if;
end if;
end process;

process(cur_state,count1,count2,count3,count4,search)
begin
next_state <= cur_state;

case cur_state is

when READ =>
next_state <= INPREG;
oup <= "00000000";
addrA <= std_logic_vector(to_unsigned(128*count2 + count1,14));
addrB <= std_logic_vector(to_unsigned(count3 + 128*count4,14));
addrC <= std_logic_vector(to_unsigned(count4 + 128*count1,14));

when INPREG =>
next_state <= OPREG;
oup <= "00011000";
addrA <= std_logic_vector(to_unsigned(count1 + 128*count2,14));
addrB <= std_logic_vector(to_unsigned(count3 + 128*count4,14));
addrC <= std_logic_vector(to_unsigned(count4 + 128*count1,14));

when OPREG =>
next_state <= MAC;
oup <= "01100000";
addrA <= std_logic_vector(to_unsigned(count1 + 128*count2,14));
addrB <= std_logic_vector(to_unsigned(count3 + 128*count4,14));
addrC <= std_logic_vector(to_unsigned(count4 + 128*count1,14));

when MAC =>
addrA <= "00000000000000";
addrB <= "00000000000000";

if ((count2 = 0) and (count3 = 0) and (count2 /= 0 or count1 /= 0 or count4 /= 0 or count3 /= 0)) then
next_state <= RAM;
addrC <= std_logic_vector(to_unsigned(count4 + 128*count1,14));
oup <= "11100011";
else
next_state <= READ;
oup <= "01100010";
addrC <= std_logic_vector(to_unsigned(count4 + 128*count1,14));
end if;

when RAM =>
if count1 = 128 then
next_state <= ENDALL;
oup <= "00000100";
else
next_state <= READ;
oup <= "00000101";
end if;

addrA <= "00000000000000";
addrB <= "00000000000000";

if count4 = 0 then
addrC <= std_logic_vector(to_unsigned(count4 + 128*count1 -1,14));
else
addrC <= std_logic_vector(to_unsigned(count4 + 128*count1-1,14));
end if;

when ENDALL =>
next_state <= ENDALL;
oup <= "00000000";
addrA <= "00000000000000";
addrB <= "00000000000000";
addrC <= search;
end case;
end process;
end behavioral;