library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity T20_TrafficLights is

    generic (
        ClockFrequency : integer
    );
    
    port (
        Clk     : in std_logic;
        nRst    : in std_logic;

        --Traffic lights
        NorthRed    : out std_logic;
        NorthYellow : out std_logic;
        NorthGreen  : out std_logic;
        WestRed     : out std_logic;
        WestYellow  : out std_logic;
        WestGreen   : out std_logic
    );

end entity;


architecture rtl of T20_TrafficLights is

    --Enumerated type declaration and state signal declaration
    type t_State is (NorthNext, StartNorth, North, StopNorth,
                     WestNext, StartWest, West, StopWest);
    

    signal state : t_State;

    --Counter for counting clock periods, 1 minute max
    signal Counter : integer range 0 to ClockFrequency * 60;

begin


    process(Clk) is
    begin

        if rising_edge(Clk) then

            if nRst = '0' then
                --Reset Values
                state <= NorthNext;
                Counter <= 0;

                NorthRed    <= '1';
                NorthYellow <= '0';
                NorthGreen  <= '0';
                WestRed     <= '1';
                WestYellow  <= '0';
                WestGreen   <= '0';

            else

                --Default signal values
                NorthRed    <= '0';
                NorthYellow <= '0';
                NorthGreen  <= '0';
                WestRed     <= '0';
                WestYellow  <= '0';
                WestGreen   <= '0';
                
                Counter <= Counter + 1;

                case state is
                    when NorthNext =>
                        --If 5 seconds have passed
                        if Counter = ClockFrequency * 5 - 1 then
                            Counter <= 0;
                            state   <= StartNorth;
                        end if;
                        NorthRed    <= '1';
                        WestRed     <= '1';

                    when StartNorth =>
                        --If 5 seconds have passed
                        if Counter = ClockFrequency * 5 - 1 then
                            Counter <= 0;
                            state   <= North;
                        end if;
                        NorthRed    <= '1';
                        NorthYellow <= '1';
                        WestRed     <= '1';                        

                    when North =>
                        --If a minute has passed
                        if Counter = ClockFrequency * 60 - 1 then
                            Counter <= 0;
                            state   <= StopNorth;
                        end if;
                        NorthGreen  <= '1';
                        WestRed     <= '1';

                    when StopNorth =>
                        --If 5 seconds have passed
                        if Counter = ClockFrequency * 5 - 1 then
                            Counter <= 0;
                            state   <= WestNext;
                        end if;
                        NorthYellow <= '1';
                        WestRed     <= '1';


                    when WestNext =>
                        --If 5 seconds have passed
                        if Counter = ClockFrequency * 5 - 1 then
                            Counter <= 0;
                            state   <= StartWest;
                        end if;                        
                        NorthRed    <= '1';
                        WestRed     <= '1';

                    when StartWest =>
                        --If 5 seconds have passed
                        if Counter = ClockFrequency * 5 - 1 then
                            Counter <= 0;
                            state   <= West;
                        end if;                        
                        NorthRed    <= '1';
                        WestRed     <= '1';
                        WestYellow  <= '1';

                    when West =>
                        --If a minute has passed
                        if Counter = ClockFrequency * 60 - 1 then
                            Counter <= 0;
                            state   <= StopWest;
                        end if;                        
                        NorthRed    <= '1';
                        WestGreen   <= '1';

                    when StopWest =>
                        --If 5 seconds have passed
                        if Counter = ClockFrequency * 5 - 1 then
                            Counter <= 0;
                            state   <= NorthNext;
                        end if;                        
                        NorthRed    <= '1';
                        WestYellow  <= '1';

                end case;

            end if;


        end if;

    end process;
    

end architecture;