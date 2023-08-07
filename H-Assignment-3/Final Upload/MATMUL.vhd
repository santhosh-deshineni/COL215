library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MATMUL is
Port (clk : in std_logic;
search : in std_logic_vector(13 downto 0);
cathode : out std_logic_vector(6 downto 0);
an : out std_logic_vector(3 downto 0));
end MATMUL;

architecture Behavioral of MATMUL is

component FSM
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
end component;

component MAC
Port ( re : in std_logic;
we : in std_logic;
clk : in std_logic;
numA : in std_logic_vector(7 downto 0);
numB : in std_logic_vector(7 downto 0);
cntrl : in std_logic;
output : out std_logic_vector(15 downto 0));
end component;

component Register8
PORT(inp : in std_logic_vector(7 DOWNTO 0);
we : IN STD_LOGIC; -- load/enable.
re : in std_logic;
clk : IN STD_LOGIC; -- clock.
q : OUT std_logic_vector(7 DOWNTO 0));
end component;

component dist_mem_gen_0
Port(a : in std_logic_vector(13 downto 0);
clk : in std_logic;
spo : out std_logic_vector(7 downto 0));
end component;

component dist_mem_gen_1
Port(a : in std_logic_vector(13 downto 0);
clk : in std_logic;
spo : out std_logic_vector(7 downto 0));
end component;

component dist_mem_gen_2
Port(a : std_logic_vector(13 downto 0);
clk : in std_logic;
d : in std_logic_vector(15 downto 0);
we : in std_logic;
spo : out std_logic_vector(15 downto 0));
end component;

signal oup : std_logic_vector(7 downto 0);
signal output : std_logic_vector(15 downto 0);
signal numA : std_logic_vector(7 downto 0);
signal numB : std_logic_vector(7 downto 0);
signal addrA : std_logic_vector(13 downto 0);
signal addrB : std_logic_vector(13 downto 0);
signal addrC : std_logic_vector(13 downto 0);
signal val : std_logic_vector(15 downto 0);
signal qA : std_logic_vector(7 downto 0);
signal qB : std_logic_vector(7 downto 0);

begin
mainfsm : FSM port map(clk => clk,oup => oup,addrA => addrA,addrB => addrB, addrC => addrC,val => val,search => search, cathode => cathode, an => an);
mainMAC : MAC port map(re => oup(0),we => oup(1),numA => qA,numB => qB,clk => clk,cntrl => oup(7),output => output);
Reg1 : register8 port map(inp => numA,clk => clk,we => oup(4),re => oup(6),q => qA);
Reg2 : register8 port map(inp => numB,clk => clk,we => oup(3),re => oup(5),q => qB);
ROM1 : dist_mem_gen_0 port map(a => addrA, spo => numA, clk=>clk);
ROM2 : dist_mem_gen_1 port map(a => addrB, spo => numB, clk=>clk);
RAM : dist_mem_gen_2 port map(a => addrC,d => output, clk => clk, we => oup(2),spo => val);
end Behavioral;