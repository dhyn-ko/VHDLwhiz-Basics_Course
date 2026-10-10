entity T02_Wait_for_Tb is
end entity;

architecture sim of T02_Wait_for_Tb is
begin

    process is
    begin
        report "Peekaboo!";
        wait for 1 hr;
    end process;

end architecture;