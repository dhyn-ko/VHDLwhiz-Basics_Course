library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T15_PortMapTb is 
end entity;


architecture sim of T15_PortMapTb is
    signal Sel : unsigned(1 downto 0) := (others => '0');

    signal Sig1 : unsigned(7 downto 0) := x"AA";
    signal Sig2 : unsigned(7 downto 0) := x"BB";
    signal Sig3 : unsigned(7 downto 0) := x"CC";
    signal Sig4 : unsigned(7 downto 0) := x"DD";

    signal Output : unsigned(7 downto 0);
begin

    --An instance of T15_MUX with architecture rtl
    i_MUX1 : entity work.T15_MUX(rtl)
    port map(
        Sel     => Sel,
        Sig1    => Sig1,
        Sig2    => Sig2,
        Sig3    => Sig3,
        Sig4    => Sig4,
        Output  => Output
    );

    --Testbench process
    process is
    begin
        wait for 10 ns;
        Sel <= Sel + 1;
        wait for 10 ns;
        Sel <= Sel + 1;
        wait for 30 ns;
        Sel <= Sel + 1;
        wait for 20 ns;
        Sel <= (others => 'U');
        wait;
    end process;

end architecture;