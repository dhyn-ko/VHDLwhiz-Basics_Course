library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T15_MUX is
    port(
        --All the inputs
        Sel : in unsigned(1 downto 0);

        Sig1 : in unsigned(7 downto 0);
        Sig2 : in unsigned(7 downto 0);
        Sig3 : in unsigned(7 downto 0);
        Sig4 : in unsigned(7 downto 0);

        --All the outputs
        Output : out unsigned(7 downto 0) );
end entity;


architecture rtl of T15_MUX is

begin

    process(Sel, Sig1, Sig2, Sig3, Sig4) is
    begin

        case Sel is
            when "00" =>
                Output <= Sig1;
            when "01" =>
                Output <= Sig2;
            when "10" =>
                Output <= Sig3;
            when "11" =>
                Output <= Sig4;
            when others => -- 'U', 'X', '-', etc.
                Output <= (others => 'X');
        end case;

    end process;

end architecture;