library ieee;
use ieee.std_logic_1164.all;

entity p4 is
    port (
        clk : in std_logic;
        X1  : in std_logic;
        X2  : in std_logic;
        INIT: in std_logic;
        Z1  : out std_logic;
        Z2  : out std_logic
    );
end p4;

architecture p4ckt of p4 is
    type state_type is (a, b, c);
    signal S, NS : state_type;
begin
    advance: process(clk, NS, INIT) begin
        if (INIT = '1') then --assuming init is a pulse
            S <= A;
        elsif (rising_edge(clk)) then
            S <= NS;
        end if;
    end process advance;
    
    machine: process (S, X1, X2) begin
        Z1 <= '0';
        Z2 <= '0';
        case S is
            when A =>
                Z1 <= '0';
                if (X1 = '1') then
                    NS <= B;
                    Z2 <= '1';
                else
                    NS <= C;
                    Z2 <= '0';
                end if;
            when B =>
                Z1 <= '1';
                if (X2 = '1') then
                    NS <= A;
                    Z2 <= '0';
                else
                    NS <= C;
                    Z2 <= '1';
                end if;
            when C =>
                Z1 <= '1';
                if (X1 = '1') then
                    NS <= B;
                    Z2 <= '1';
                else
                    NS <= A;
                    Z2 <= '1';
                end if;
            when others =>
                NS <= A;
                Z1 <= '0';
                Z2 <= '0';
        end case;
    end process machine;
end p4ckt;