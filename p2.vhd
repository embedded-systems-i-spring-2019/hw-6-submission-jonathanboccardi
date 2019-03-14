library ieee;
use ieee.std_logic_1164.all;

entity p2 is
    port (
        clk : in std_logic;
        X1  : in std_logic;
        X2  : in std_logic;
        Z   : out std_logic;
        Y   : out std_logic_vector(1 downto 0)        
    );
end p2;

architecture p2ckt of p2 is
    type state_type is (a, b, c);
    attribute enum_encoding : string;
    attribute enum_encoding of state_type   : type is "10 11 01";
    signal NS, PS : state_type;
begin
    advance: process(clk, NS) begin
        if (rising_edge(clk)) then
            PS <= NS;
        end if;
    end process advance;
    
    machine: process(PS, X1, X2) begin
        Z <= '0';
        case PS is 
            when A =>
                if (X1 = '1') then
                    NS <= C;
                    Z <= '0';
                else
                    NS <= A;
                    Z <= '0';
                end if;
            when B =>
                if (X2 = '1') then
                    NS <= B;
                    Z <= '0';
                else
                    NS <= A;
                    Z <= '1';
                end if;
            when C =>
                if (X2 = '1') then
                    NS <= B;
                    Z <= '0';
                else
                    NS <= A;
                    Z <= '1';
                end if;
            when others =>
                NS <= A;
                Z <= '0';
        end case;
    end process machine;
    
    with PS select
        Y <=    "10" when A,
                "11" when B,
                "01" when C,
                "10" when others;
end p2ckt;