library ieee;
use ieee.std_logic_1164.all;

entity p13 is
    port (
        clk : in std_logic;
        X1  : in std_logic;
        X2  : in std_logic;
        CS  : out std_logic;
        RD  : out std_logic;
        Y   : out std_logic_vector(2 downto 0)
    );
end p13;

architecture p13ckt of p13 is
    type state_type is (A, B, C);
    attribute enum_encoding : string;
    attribute enum_encoding of state_type : type is "001 010 100";
    signal S, NS    : state_type;
begin
    advance: process(clk, NS) begin
        if (rising_edge(clk)) then
            S <= NS;
        end if;
    end process advance;
    
    machine: process(S, X1, X2) begin
        CS <= '0';
        RD <= '0';
        case S is
            when A =>
                if (X1 = '1') then
                    NS <= C;
                    CS <= '1';
                    RD <= '0';
                else
                    NS <= B;
                    CS <= '0';
                    RD <= '1';
                end if;
            when B =>
                NS <= C;
                CS <= '1';
                RD <= '1';
            when C =>
                if (X2 = '1') then
                    NS <= C;
                    CS <= '0';
                    RD <= '1';
                else
                    NS <= A;
                    CS <= '0';
                    RD <= '0';
                end if;
            when others =>
                NS <= A;
                CS <= '0';
                RD <= '0';
        end case;
    end process machine;
end p13ckt;