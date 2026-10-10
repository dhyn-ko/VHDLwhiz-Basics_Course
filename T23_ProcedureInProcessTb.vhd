library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T23_ProcedureInProcessTb is
end entity;

architecture sim of T23_ProcedureInProcessTb is

    constant ClockFrequencyTb   : integer := 100;
    constant ClockPeriodTb      : time := 1000 ms / ClockFrequencyTb;

    signal ClockTb              : std_logic := '1';
    signal nRstTb               : std_logic := '0';

    signal NorthRedTb           : std_logic;
    signal NorthYellowTb        : std_logic;
    signal NorthGreenTb         : std_logic;

    signal WestRedTb            : std_logic;
    signal WestYellowTb         : std_logic;
    signal WestGreenTb          : std_logic;


begin


    i_TrafficLights : entity work.T23_TrafficLights(rtl)
    generic map(
        ClockFrequency => ClockFrequencyTb
    )
    port map(
        Clk => ClockTb,
        nRst => nRstTb,

        NorthRed => NorthRedTb,
        NorthYellow => NorthYellowTb,
        NorthGreen => NorthGreenTb,
        WestRed => WestRedTb,
        WestYellow => WestYellowTb,
        WestGreen => WestGreenTb
    );


    ClockTb <= not ClockTb after ClockPeriodTb/2;

    process is
    begin


        wait until rising_edge(ClockTb);
        wait until rising_edge(ClockTb);

        nRstTb <= '1'; --Take DUT out of reset

        wait;


    end process;



end architecture;