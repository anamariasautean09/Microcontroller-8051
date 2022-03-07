----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:39:27 AM
-- Design Name: 
-- Module Name: fetch_tb - Behavioral
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

entity fetch_tb is
--  Port ( );
end fetch_tb;

architecture Behavioral of fetch_tb is

signal jmpaddr: std_logic_vector(15 downto 0):=(others =>'0');
signal jmpsrc:std_logic:='0';
signal braddr: std_logic_vector(15 downto 0):=(others=>'0');
signal brsrc: std_logic:='0'; 
signal instr1: std_logic_vector(7 downto 0);
signal instr2: std_logic_vector(7 downto 0);
signal instr3: std_logic_vector(7 downto 0);
signal next_instr: std_logic_vector(15 downto 0); 
signal en: std_logic:='1';
signal enRes: std_logic:='0';
signal clk:std_logic:='0';
signal pcout:std_logic_vector(15 downto 0);
 
constant CLK_PERIOD : TIME := 10 ns;

begin

DUT: entity Work.instr_fetch port map
(jmpaddr=>jmpaddr,
 jmpsrc=>jmpsrc,
 braddr=>braddr,
 brsrc=>brsrc,
 instr1=>instr1,
 instr2=>instr2,
 instr3=>instr3,
 next_instr=>next_instr,
 en=>en,
 enRes=>enRes,
 clk=>clk,
 pcout=>pcout);
 
gen_clk: process
         begin
            Clk <= '0';
            wait for (CLK_PERIOD/2);
            Clk <= '1';
            wait for (CLK_PERIOD/2);
        end process gen_clk;

tb_proc:process
        begin
            enRes<='1';
            wait for CLK_PERIOD;
            enRes<='0';
            wait for CLK_PERIOD;
            wait for 300 ns;
            wait;
        end process;

end Behavioral;
