library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8_to_1_case is
    Port (
        inputs : in  STD_LOGIC_VECTOR(7 downto 0);
        sel    : in  STD_LOGIC_VECTOR(2 downto 0);
        output : out STD_LOGIC
    );
end mux_8_to_1_case;

architecture Behavioral of mux_8_to_1_case is
begin
    process (sel, inputs)
    begin
        case sel is
            when "000" =>
                output <= inputs(0);
            when "001" =>
                output <= inputs(1);
            when "010" =>
                output <= inputs(2);
            when "011" =>
                output <= inputs(3);
            when "100" =>
                output <= inputs(4);
            when "101" =>
                output <= inputs(5);
            when "110" =>
                output <= inputs(6);
            when "111" =>
                output <= inputs(7);
            when others =>
                output <= '0'; -- Default case
        end case;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_3Bit_Load_Reset is
    Port (
        clk   : in  STD_LOGIC;      -- Semnal de ceas
        load  : in  STD_LOGIC;      -- Semnal de înc?rcare (activ pe 1)
        reset : in  STD_LOGIC;      -- Semnal de reset (activ pe 0)
        count : out STD_LOGIC_VECTOR(2 downto 0)  -- Contor pe 3 bi?i
    );
end Counter_3Bit_Load_Reset;

architecture Behavioral of Counter_3Bit_Load_Reset is
    signal counter_value : STD_LOGIC_VECTOR(2 downto 0) := "000";  -- Valoarea contorului

begin
    process(clk, reset)
    begin
        if reset = '0' then
            counter_value <= "000";  -- Resetare la 0
        elsif rising_edge(clk) then
            if load = '1' then
                -- Înc?rcare valoare nou? la nivelul de ceas cresc?tor
                counter_value <= (others => '0');  -- Pute?i înlocui cu valoarea dorit? pentru înc?rcare
            else
                -- Incrementare normal? la nivelul de ceas cresc?tor
                counter_value <= counter_value + 1;
            end if;
        end if;
    end process;

    count <= counter_value;  -- Ie?irea este valoarea contorului
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
    Port (
        clk : in std_logic;
        Qout : out std_logic_vector(2 downto 0)
    );
end circuit;

architecture Behavioral of circuit is
    component mux_8_to_1_case
        Port (
            inputs : in  STD_LOGIC_VECTOR(7 downto 0);
            sel    : in  STD_LOGIC_VECTOR(2 downto 0);
            output : out STD_LOGIC
        );
    end component;

    component Counter_3Bit_Load_Reset
        Port (
            clk   : in  STD_LOGIC;      -- Semnal de ceas
            load  : in  STD_LOGIC;      -- Semnal de înc?rcare (activ pe 1)
            reset : in  STD_LOGIC;      -- Semnal de reset (activ pe 0)
            count : out STD_LOGIC_VECTOR(2 downto 0)  -- Contor pe 3 bi?i
        );
    end component;

    signal Qin : std_logic_vector(2 downto 0) := "000";
    signal sell : std_logic_vector(2 downto 0) := "000";
    signal input_mux1 : std_logic_vector(7 downto 0) := "01100100";
    signal input_mux2 : std_logic_vector(7 downto 0) := "01000111";
    signal input_mux3 : std_logic_vector(7 downto 0) := "10111101";
    
     signal sel_mux : std_logic_vector(2 downto 0) := "000"; -- Semnal nou pentru controlul selec?iei multiplexoarelor

begin
    Mux1 : mux_8_to_1_case port map(inputs => input_mux1, sel => sel_mux, output => Qin(2));
    Mux2 : mux_8_to_1_case port map(inputs => input_mux2, sel => sel_mux, output => Qin(1));
    Mux3 : mux_8_to_1_case port map(inputs => input_mux3, sel => sel_mux, output => Qin(0));

    Counter : Counter_3Bit_Load_Reset port map(clk => clk, load => '1', reset => '1', count => Qin);
    sel_mux <= Qin; -- Acum, sel_mux preia valoarea din Qin, eliminând dependen?a circular?


end Behavioral;