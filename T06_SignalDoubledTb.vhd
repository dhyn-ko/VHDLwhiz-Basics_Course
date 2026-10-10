entity T06_SignalDoubledTb is
end entity;

architecture sim of T06_SignalDoubledTb is
    signal MySignal : integer := 0;
begin

    process is
        variable MyVariable : integer := 0;
    begin

        report "---PROCESS RESTART---";

        --FIRST Variable increment
        MyVariable := MyVariable + 1;
        MySignal <= MySignal + 1;

        report "MyVariable = " & integer'image(MyVariable) & ", MySignal = " & integer'image(MySignal);


        --SECOND Variable increment
        MyVariable := MyVariable + 1;
        MySignal <= MySignal + 1;

        report "MyVariable = " & integer'image(MyVariable) & ", MySignal = " & integer'image(MySignal);


        wait for 10 ns;

        report "*AFTER ""wait"" statement* MyVariable = " & integer'image(MyVariable) & ", MySignal (UPDATED) = " & integer'image(MySignal);

    end process; 

end architecture;