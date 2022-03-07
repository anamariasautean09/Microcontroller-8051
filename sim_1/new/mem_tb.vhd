----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:38:26 AM
-- Design Name: 
-- Module Name: mem_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_tb is
--  Port ( );
end mem_tb;

architecture Behavioral of mem_tb is

signal addr1:std_logic_vector(7 downto 0):=(others => '0');
signal addr2: std_logic_vector(7 downto 0):=(others => '0');
signal addr3:std_logic_vector(7 downto 0):=(others => '0');
signal addr4: std_logic_vector(7 downto 0):=(others => '0');
signal data_in1: std_logic_vector(7 downto 0):=(others => '0');
signal data_in2: std_logic_vector(7 downto 0):=(others => '0');
signal data_out1: std_logic_vector(7 downto 0);
signal data_out2: std_logic_vector(7 downto 0);
signal clk: std_logic:='0';
signal MemWrite1: std_logic:='0';
signal MemWrite2: std_logic:='0';
signal wen:std_logic:='0' ;

constant CLK_PERIOD : TIME := 10 ns;

begin
gen_clk: process
         begin
            clk <= '0';
            wait for (CLK_PERIOD/2);
            clk <= '1';
            wait for (CLK_PERIOD/2);
        end process gen_clk;
 
DUT: entity work.mem_ram port map
 (addr1=>addr1,
  addr2=>addr2,
  addr3=>addr3,
  addr4=>addr4,
  data_in1=>data_in1,
  data_in2=>data_in2,
  data_out1=>data_out1,
  data_out2=>data_out2,
  clk=>clk,
  MemWrite1=>MemWrite1,
  MemWrite2=>MemWrite2,
  wen=>wen);
  
 tb_proc: process
          begin
            wen<='0';
            addr3<=x"00";
            addr4<=x"01";
            addr1<=x"02";
            addr2<=x"03"; 
            wait for 10 ns;
  
            wen<='1';
            MemWrite1<='1';
            MemWrite2<='1';
            addr1<=x"00";
            addr2<=x"01";
            addr3<=x"02";
            addr4<=x"03";
            data_in1<=x"11";
            data_in2<=x"10";
            wait for 10 ns;
  
            MemWrite1<='0';
            MemWrite2<='0';
            data_in1<=x"00";
            data_in2<=x"00";
            wen<='0';
            addr3<=x"00";
            addr4<=x"01";
            addr1<=x"02";
            addr2<=x"03";
            wait for 10 ns;
            wait;
        end process;


end Behavioral;
