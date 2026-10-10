library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity T22_TrafficLights is

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


architecture rtl of T22_TrafficLights is

    --Enumerated type declaration and state signal declaration
    type t_State is (NorthNext, StartNorth, North, StopNorth,
                     WestNext, StartWest, West, StopWest);
    

    signal state : t_State;

    --Counter for counting clock periods, 1 minute max
    signal Counter : integer range 0 to ClockFrequency * 60;


    --Function for determining needed clock cycles for given time period
    function CounterVal(
        Seconds : integer := 0;
        Minutes : integer := 0
    ) 
    return integer is

        variable TotalSeconds : integer;

    begin
        TotalSeconds := Seconds + Minutes * 60;
        return TotalSeconds * ClockFrequency - 1;
    end function;


begin


    process(Clk) is

        --Simulation failes despite successful compilation due to 
        --GHDL being strict about functions, both impure and pure,
        --not being able to assign values to signals at all.
        --NVC (newly installed compiler) also throws an error
        impure function CounterExpired(
            Minutes : integer := 0;
            Seconds : integer := 0
        ) return boolean is
        begin

            if Counter = CounterVal(Minutes, Seconds) then
                Counter <= 0;
                return true;
            else
                return false;
            end if;

        end function;

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
                        if CounterExpired(Seconds => 5) then
                            state   <= StartNorth;
                        end if;
                        NorthRed    <= '1';
                        WestRed     <= '1';

                    when StartNorth =>
                        --If 5 seconds have passed
                        if CounterExpired(Seconds => 5) then
                            state   <= North;
                        end if;
                        NorthRed    <= '1';
                        NorthYellow <= '1';
                        WestRed     <= '1';                        

                    when North =>
                        --If a minute has passed
                        if CounterExpired(Minutes => 1) then
                            state   <= StopNorth;
                        end if;
                        NorthGreen  <= '1';
                        WestRed     <= '1';

                    when StopNorth =>
                        --If 5 seconds have passed
                        if CounterExpired(Seconds => 5) then
                            state   <= WestNext;
                        end if;
                        NorthYellow <= '1';
                        WestRed     <= '1';


                    when WestNext =>
                        --If 5 seconds have passed
                        if CounterExpired(Seconds => 5) then
                            state   <= StartWest;
                        end if;                        
                        NorthRed    <= '1';
                        WestRed     <= '1';

                    when StartWest =>
                        --If 5 seconds have passed
                        if CounterExpired(Seconds => 5) then
                            state   <= West;
                        end if;                        
                        NorthRed    <= '1';
                        WestRed     <= '1';
                        WestYellow  <= '1';

                    when West =>
                        --If a minute has passed
                        if CounterExpired(Minutes => 1) then
                            state   <= StopWest;
                        end if;                        
                        NorthRed    <= '1';
                        WestGreen   <= '1';

                    when StopWest =>
                        --If 5 seconds have passed
                        if CounterExpired(Seconds => 5) then
                            state   <= NorthNext;
                        end if;                        
                        NorthRed    <= '1';
                        WestYellow  <= '1';

                end case;

            end if;


        end if;

    end process;
    

end architecture;