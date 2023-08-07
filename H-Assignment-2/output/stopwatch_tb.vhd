library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stopwatch_tb is
end stopwatch_tb;

architecture Behavioral of stopwatch_tb is
component stopwatch 
    Port(start: in STD_LOGIC;
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
end component;
signal start,pause,continue,reset,clk,a,b,c,d,e,f,g,an0,an1,an2,an3,depo : std_logic;

begin
UUT : stopwatch port map (start => start,pause =>pause,continue => continue, reset => reset,clk => clk,a => a,b => b,c => c, d=> d,e=> e, f => f,g => g, an0 => an0, an1 => an1, an2 => an2, an3 => an3,depo => depo);
start <= '1';
pause <= '0';
continue <= '0';
reset <= '0';
clk <= '0', '1' after 10ns, '0' after 20ns, '1' after 30ns, '0' after 40ns, '1' after 50ns, '0' after 60ns, '1' after 70ns, '0' after 80ns, '1' after 90ns, '0' after 100ns, '1' after 110ns, '0' after 120ns, '1' after 130ns, '0' after 140ns, '1' after 150ns, '0' after 160ns, '1' after 170ns, '0' after 180ns, '1' after 190ns, '0' after 200ns, '1' after 190ns, '0' after 200ns, '1' after 210ns, '0' after 220ns, '1' after 230ns, '0' after 240ns, '1' after 250ns, '0' after 260ns, '1' after 270ns, '0' after 280ns, '1' after 290ns, '0' after 300ns, '1' after 310ns, '0' after 320ns, '1' after 330ns, '0' after 340ns, '1' after 350ns, '0' after 360ns, '1' after 370ns, '0' after 380ns, '1' after 390ns, '0' after 400ns, '1' after 410ns, '0' after 420ns, '1' after 430ns, '0' after 440ns, '1' after 450ns, '0' after 460ns, '1' after 470ns, '0' after 480ns, '1' after 490ns, '0' after 500ns,'1' after 510ns, '0' after 520ns, '1' after 530ns, '0' after 540ns, '1' after 550ns, '0' after 560ns, '1' after 570ns, '0' after 580ns, '1' after 590ns, '0' after 600ns, '1' after 610ns, '0' after 620ns, '1' after 630ns, '0' after 640ns, '1' after 650ns, '0' after 660ns, '1' after 670ns, '0' after 680ns, '1' after 690ns, '0' after 700ns, '1' after 710ns, '0' after 720ns, '1' after 730ns, '0' after 740ns, '1' after 750ns, '0' after 760ns, '1' after 770ns, '0' after 780ns, '1' after 790ns, '0' after 800ns, '1' after 810ns, '0' after 820ns, '1' after 830ns, '0' after 840ns, '1' after 850ns, '0' after 860ns, '1' after 870ns, '0' after 880ns, '1' after 890ns, '0' after 900ns, '1' after 910ns, '0' after 920ns, '1' after 930ns, '0' after 940ns, '1' after 950ns, '0' after 960ns, '1' after 970ns, '0' after 980ns, '1' after 990ns, '0' after 1000ns;

end Behavioral;
