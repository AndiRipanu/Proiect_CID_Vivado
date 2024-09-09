library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_circuit is
end tb_circuit;

architecture testbench of tb_circuit is
    signal clk_tb : STD_LOGIC := '0';  -- Clock signal
    signal Qout_tb : STD_LOGIC_VECTOR(2 downto 0);

    component circuit
        Port (
            clk : in std_logic;
            Qout : out std_logic_vector(2 downto 0)
        );
    end component;

    -- Clock process
    constant clock_period : time := 10 ns;  -- Clock period of 10 ns
    signal sel_mux_tb : std_logic_vector(2 downto 0) := "000"; -- Initial value for sel_mux
    signal input_mux1_tb : std_logic_vector(7 downto 0) := "01100100";
    signal input_mux2_tb : std_logic_vector(7 downto 0) := "01000111";
    signal input_mux3_tb : std_logic_vector(7 downto 0) := "10111101";

    begin
        clk_process: process
        begin
            while now < 1000 ns  -- Simulate for 1000 ns
                loop
                    clk_tb <= not clk_tb;  -- Toggle the clock
                    wait for clock_period / 2;
                end loop;
            wait;
        end process clk_process;

    -- Instantiate the circuit
    


    UUT : circuit port map(clk => clk_tb, Qout => Qout_tb);

    -- Stimulus process
    stimulus_process: process
    begin
        wait for 20 ns;  -- Wait for initial stabilization

        -- Set input values
        input_mux1_tb <= "01100100";
        input_mux2_tb <= "01000111";
        input_mux3_tb <= "10111101";

        wait for 10 ns;  -- Wait for stable inputs

        -- Change inputs for the second cycle
        input_mux1_tb <= "11110000";
        input_mux2_tb <= "00101010";
        input_mux3_tb <= "11001100";

        wait for 80 ns;  -- Wait for simulation to end

        assert false report "Simulation complete" severity note;
        wait;
    end process stimulus_process;
end testbench;