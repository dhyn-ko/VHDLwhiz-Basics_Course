library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T19_Timer is

    generic(
        Clockfrequency : integer
    );
    port(
        --Clock and negative reset
        Clk     : in std_logic;
        nRst    : in std_logic;

        Seconds : inout integer;
        Minutes : inout integer;
        Hours   : inout integer
    );

end entity;

architecture rtl of T19_Timer is

    signal ticks : integer;

    procedure IncrementWrap(
        signal      Counter     : inout integer;
        constant    WrapValue   : in    integer;
        constant    Enable      : in    boolean;
        variable    Wrapped     : out   boolean) 

        -- Significance of the data types:
        -- Notice how in the instances of IncrementWrap,
        -- the local process variable value (declared in the process)
        -- called "WRAP" is copied into BOTH Enable and Wrapped.

        -- Enable is a CONSTANT value that is only READ.
        -- Wrapped is a VARIABLE value that is an OUTPUT.
        
        -- Therefore, in each instance of this procedure, VHDL makes a copy 
        -- of WRAP and puts it into "Enable" that can never be changed within 
        -- that instance of the procedure and can only be read. Meanwhile, 
        -- "Wrapped" is used to make changes to the WRAP value, which can then
        -- have an influence on the following instance of the procedure, since
        -- it is an output and therefore also visible to the rest of the process.

        -- This is why "Enable" is checked only once and there is no attempt
        -- to change its value. "Wrapped" is never read, only ever assigned 
        -- output values.

        -- A good way to think about this is the method of addressing a
        -- variable by value vs. addressing it by reference.

        -- This is exactly how the compartmentalization of the timer has
        -- been implemented using a procedure instead of nested conditions.
        
        -- The counter for ticks is always enabled and always counts. 
        -- When does the seconds counter get enabled and increment or reset?
        -- It's when "Wrapped" from the ticks was set to true due to a reset
        -- of the ticks, leading to an output of "true" for the process
        -- variable WRAP, enabling the Seconds counter and checking whether
        -- to increment or reset.
        
        is
        begin
            
            Wrapped := false;
            if Enable then

                if Counter = WrapValue - 1 then

                    Wrapped := true;
                    Counter <= 0;

                else

                    Counter <= Counter + 1;
                    
                end if;

            end if;


    end procedure;
                    

begin
    
    process(Clk) is
        variable Wrap : boolean;
    begin

        if rising_edge(Clk) then

            if nRst = '0' then

                ticks   <= 0;

                Seconds <= 0;
                Minutes <= 0;
                Hours   <= 0;

            else

                IncrementWrap(ticks, Clockfrequency, true, Wrap);
                IncrementWrap(Seconds, 60, Wrap, Wrap);
                IncrementWrap(Minutes, 60, Wrap, Wrap);
                IncrementWrap(Hours, 24, Wrap, Wrap);

            end if;

        end if;


    end process;


end architecture;