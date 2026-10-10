library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity T18_Timer is
    generic(
        Clockfrequency : integer
    );
    port(
        --Clock and negative reset
        Clk     : in    std_logic;
        nRst    : in    std_logic;

        Seconds : inout integer;
        Minutes : inout integer;
        Hours   : inout integer
    );
end entity;

architecture rtl of T18_Timer is
    signal Ticks : integer;
begin

    process(Clk) is
    begin


        if rising_edge(clk) then

            --Reset is activated:
            if nRst = '0' then
                Ticks   <= 0;

                Seconds <= 0;
                Minutes <= 0;
                Hours   <= 0;
            else

                --True every SECOND
                if Ticks = Clockfrequency -1 then
                    Ticks <= 0;

                    --True every MINUTE
                    if Seconds = 59 then
                        Seconds <= 0;

                        --True every HOUR
                        if Minutes = 59 then
                            Minutes <= 0;

                            --True every DAY (nonexistent signal)
                            if Hours = 23 then
                                Hours <= 0;

                            else
                                Hours <= Hours + 1;
                            end if;

                        else
                            Minutes <= Minutes + 1;
                        end if;

                    else
                        Seconds <= Seconds + 1;
                    end if;

                else
                    Ticks <= Ticks + 1;
                end if;

            end if;
            
        end if;



    end process;

end architecture;