library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
  Port (input : in std_logic_vector(3 downto 0);
  seg : out std_logic_vector(6 downto 0));
end Decoder;

architecture Behavioral of Decoder is
signal a:std_logic;
signal b:std_logic;
signal c:std_logic;
signal d:std_logic;
begin
a <= input(3);
b <= input(2);
c <= input(1);
d <= input(0);
seg(6) <= ((not a) AND (not b) AND (not c) AND d) OR ((not a) AND b AND (not c) AND (not d)) OR (a AND (not b) AND c AND d) OR (a AND b AND (not c) AND d);
seg(5) <= (b AND c AND (not d)) OR (a AND b AND (not d)) OR (a AND c AND d) OR ((not a) AND b AND (not c) AND d);
seg(4) <= ((not a) AND (not b) AND c AND (not d)) OR (a AND b AND (not d)) OR (a AND b AND c);
seg(3) <= (b AND c AND d) OR ((not a) AND (not b) AND (not c) AND d) OR ((not a) AND b AND (not c) AND (not d)) OR (a AND (not b) AND c AND (not d));
seg(2) <= ((not a) AND d) OR ((not b) AND (not c) AND d) OR ((not a) AND b AND (not c));
seg(1) <= ((not a) AND (not b) AND d) OR ((not a) AND (not b) AND c) OR ((not a) AND c AND d) OR (a AND b AND (not c) AND d);
seg(0) <= ((not a) AND (not b) AND (not c)) OR (a AND b AND (not c) AND (not d)) OR ((not a) AND b AND c AND d);

end Behavioral;