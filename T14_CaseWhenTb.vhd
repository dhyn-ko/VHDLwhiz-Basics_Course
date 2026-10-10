library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T14_CaseWhenTb is 
end entity;


architecture sim of T14_CaseWhenTb is
    signal Sel : unsigned(1 downto 0) := (others => '0');

    signal Sig1 : unsigned(7 downto 0) := x"AA";
    signal Sig2 : unsigned(7 downto 0) := x"BB";
    signal Sig3 : unsigned(7 downto 0) := x"CC";
    signal Sig4 : unsigned(7 downto 0) := x"DD";

    signal Out1 : unsigned(7 downto 0);
    signal Out2 : unsigned(7 downto 0);
begin

    --Selector changes
    process is
    begin
        wait for 10 ns;
        Sel <= Sel + 1;
        wait for 10 ns;
        Sel <= Sel + 1;
        wait for 30 ns;
        Sel <= Sel + 1;
        wait for 20 ns;
        Sel <= (others => 'U');
        wait;
    end process;

    --MUX 1 with if else
    process(Sel, Sig1, Sig2, Sig3, Sig4) is
    begin
        if Sel = "00" then
            Out1 <= Sig1;
        elsif Sel = "01" then
            Out1 <= Sig2;
        elsif Sel = "10" then
            Out1 <= Sig3;
        elsif Sel = "11" then
            Out1 <= Sig4;
        else -- value is not defined
            Out1 <= (others => 'X');
        end if;
    end process;

    --MUX 2 with cases
    process(Sel, Sig1, Sig2, Sig3, Sig4) is
    begin
        case Sel is
            when "00" =>
                Out2 <= Sig1;
            when "01" =>
                Out2 <= Sig2;
            when "10" =>
                Out2 <= Sig3;
            when "11" =>
                Out2 <= Sig4;
            when others => -- value is not defined
                Out2 <= (others => 'X');
        end case;
    end process;
end architecture;