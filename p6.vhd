library ieee;
use ieee.std_logic_1164.all;

entity p6 is
    port (
        clk : in std_logic;
        X   : in std_logic;
        Z1  : out std_logic;
        Z2  : out std_logic;
        Y   : out std_logic_vector(1 downto 0)
    );
end p6;

architecture p6ckt of p6 is
    type state_type is (A, B, C, D);
    attribute enum_encoding : string;
    attribute enum_encoding of state_type : type is "00 01 10 11";
    signal S, NS : state_type;
begin
    advance: process(clk, NS) begin
        if (rising_edge(clk)) then
            S <= NS;
        end if;
    end process advance;
    
    machine: process(S, X) begin
        Z1 <= '0';
        Z2 <= '0';
        case S is
            when A =>
                Z1 <= '1';
                if (X = '1') then
                    NS <= A;
                    Z2 <= '0';
                else
                    NS <= C;
                    Z2 <= '0';
                end if;
            when B =>
                Z1 <= '0';
                if (X = '1') then
                    NS <= B;
                    Z2 <= '0';
                else
                    NS <= D;
                    Z2 <= '0';
                end if;                
            when C =>
                Z1 <= '1';
                if (X = '1') then
                    NS <= A;
                    Z2 <= '0';
                else
                    NS <= B;
                    Z2 <= '0';
                end if;
            when D =>
                Z1 <= '0';
                if (X = '1') then
                    NS <= B;
                    Z2 <= '0';
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
    
    with S select
        Y <=    "00" when A,
                "01" when B,
                "10" when C,
                "11" when D,
                "00" when others;
end p6ckt;
