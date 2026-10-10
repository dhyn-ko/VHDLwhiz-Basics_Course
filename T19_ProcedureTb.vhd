library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T19_ProcedureTb is
end entity;


architecture sim of T19_ProcedureTb is
    constant Tb_Clock_Frequency     : integer   := 10;
    constant Tb_ClockPeriod         : time      := 10 ns;

    -- Usually, for the clock frequency and clock period, the two values are
    -- dependent on each other, since the frequency is simply one divided by
    -- the period. However GHDL's 64-bit integer for value type "time" overflows
    -- (due to it counting in femtoseconds as a default) at (2^63)-1 fs, equal
    -- to 2.56 hours.

    -- Therefore, I set the period to a value of 10 ns, and the frequency to
    -- a value of "10." Obviously, if we were to think in Hertz, this value of
    -- "10 Hertz" is completely wrong due to the relationship between the
    -- period, frequency, and the unit of the second.
    
    -- Just out of convenience, I made it so that the period is 10 ns, which would
    -- usually require a frequency of 100 MHz like in the previous testbenches. The
    -- upside to this configuration is that regardless of how the period is set,
    -- because we have accepted that we are now working with a "virtual" and
    -- incorrect second, I can just say that a clock cycle is completed every 10
    -- ticks. 

    -- A runtime of 20 ms should suffice for two "virtual" days

    

    signal Tb_Clk   : std_logic := '1';
    signal Tb_nRst  : std_logic := '0';     --DUT initally in state "reset"

    signal Tb_Seconds  : integer;
    signal Tb_Minutes  : integer;
    signal Tb_Hours    : integer;

begin

    i_Timer : entity work.T19_Timer(rtl)
    generic map(
        Clockfrequency => Tb_Clock_Frequency
    )
    port map(
        Clk     => Tb_Clk,
        nRst    => Tb_nRst,
        Seconds => Tb_Seconds,
        Minutes => Tb_Minutes,
        Hours   => Tb_Hours
    );

    --Concurrent process for the clock
    Tb_Clk <= not Tb_Clk after Tb_ClockPeriod / 2;

    --Testbench sequence
    process is
    begin

        wait until rising_edge(Tb_Clk);
        wait until rising_edge(Tb_Clk);

        --Take DUT out of "reset"
        Tb_nRst <= '1';

        wait;

    end process;


end architecture;