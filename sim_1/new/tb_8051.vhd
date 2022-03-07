----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:28:37 AM
-- Design Name: 
-- Module Name: tb_8051 - Behavioral
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

entity tb_8051 is
--  Port ( );
end tb_8051;

architecture Behavioral of tb_8051 is

signal clk:std_logic:='0';
signal en:std_logic:='0';
signal wen:std_logic:='0';
signal instruction: std_logic_vector(23 downto 0);
signal next_instruction: std_logic_vector(15 downto 0);
signal opp1: std_logic_vector(7 downto 0);
signal opp2: std_logic_vector(7 downto 0);
signal result: std_logic_vector(7 downto 0);
signal psw_reg: std_logic_vector(7 downto 0);
signal branch_addr:std_logic_vector(15 downto 0);
signal jmp_address:std_logic_vector(15 downto 0);
           
constant CLK_PERIOD : TIME := 10 ns;

begin
gen_clk: process
         begin
            clk <= '0';
            wait for (CLK_PERIOD/2);
            clk <= '1';
            wait for (CLK_PERIOD/2);
         end process gen_clk;
 
DUT: entity Work.test_8051 port map
           (clk=>clk,
            en=>en,
            wen=>wen,
            instruction=>instruction,
            next_instruction=>next_instruction,
            opp1=>opp1,
            opp2=>opp2,
            result=>result,
            psw_reg=>psw_reg,
            branch_addr=>branch_addr,
            jmp_address=>jmp_address);
           
           
 tb_proc: process
          begin
            for i in 0 to 80 loop
                en<='1';
                wen<='1';
                wait for 5 ns;
                wen<='0';
                en<='0';
                wait for 20 ns;
            end loop;
            wait;
          end process;

end Behavioral;
