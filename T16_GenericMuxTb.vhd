library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T16_GenericMuxTb is
end entity;

architecture sim of T16_GenericMuxTb is

    constant TDataWidth : integer := 8;

    signal TSel : unsigned (1 downto 0);

    signal TSig1 : unsigned(TDataWidth-1 downto 0) := x"AA";
    signal TSig2 : unsigned(TDataWidth-1 downto 0) := x"BB";
    signal TSig3 : unsigned(TDataWidth-1 downto 0) := x"CC";
    signal TSig4 : unsigned(TDataWidth-1 downto 0) := x"DD";

    signal TOutput : unsigned(TDataWidth-1 downto 0);

begin

    i_Mux1 : entity work.T16_GenericMux(rtl)
    generic map(
        DataWidth => TDataWidth
    )

    port map(
        Sel => TSel,

        Sig1 => TSig1,
        Sig2 => TSig2,
        Sig3 => TSig3,
        Sig4 => TSig4,

        Output => TOutput
    );

    process is
    begin

        TSel <= "00";
        wait for 20 ns;
        TSel <= "01";
        wait for 30 ns;
        TSel <= "10";
        wait for 25 ns;
        TSel <= "11";
        wait for 15 ns;
        Tsel <= (others => 'U');
        wait;

    end process;



end architecture;