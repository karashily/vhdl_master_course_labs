library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- Add your library and packages declaration here ...

entity manager_tb is
	-- Generic declarations of the tested unit
	generic(
		N : INTEGER := 8;
		MEM_SIZE : INTEGER := 8 );
end manager_tb;

architecture TB_ARCHITECTURE of manager_tb is
	-- Component declaration of the tested unit
	component manager
		generic(
			N : INTEGER := 8;
			MEM_SIZE : INTEGER := 8 );
		port(
			clk : in STD_LOGIC;
			en : in STD_LOGIC;
			src_addr : in STD_LOGIC_VECTOR(MEM_SIZE-1 downto 0);
			dest_addr : in STD_LOGIC_VECTOR(MEM_SIZE-1 downto 0);
			array_size : in STD_LOGIC_VECTOR(MEM_SIZE downto 0);
			finish : out STD_LOGIC;
			number : out STD_LOGIC_VECTOR(N-1 downto 0) );
	end component;
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal en : STD_LOGIC;
	signal src_addr : STD_LOGIC_VECTOR(MEM_SIZE-1 downto 0);
	signal dest_addr : STD_LOGIC_VECTOR(MEM_SIZE-1 downto 0);
	signal array_size : STD_LOGIC_VECTOR(MEM_SIZE downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal finish : STD_LOGIC;
	signal number : STD_LOGIC_VECTOR(N-1 downto 0);
	
	constant clk_period : time := 10ns;
begin
	UUT : manager
	generic map (
		N => N,
		MEM_SIZE => MEM_SIZE
		)
	
	port map (
		clk => clk,
		en => en,
		src_addr => src_addr,
		dest_addr => dest_addr,
		array_size => array_size,
		finish => finish,
		number => number
		);
	
	mian: process
	begin	  	
		en <= '0';
		src_addr <= "00000000";	-- 0
		dest_addr <= "00001010"; -- 10
		array_size <= "000001010"; -- 10
		
		wait for clk_period / 4;
		
		en <= '1';
		
		wait for clk_period / 4; 
		
		wait for 20 * clk_period;
		
		report "End of simulation" severity failure;
	end process;
	
	clk_process: process
	begin					   				 
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_manager of manager_tb is
	for TB_ARCHITECTURE
		for UUT : manager
			use entity work.manager(manager);
		end for;
	end for;
end TESTBENCH_FOR_manager;
