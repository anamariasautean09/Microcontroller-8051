----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:41:11 AM
-- Design Name: 
-- Module Name: dec_tb - Behavioral
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

entity dec_tb is
--  Port ( );
end dec_tb;

architecture Behavioral of dec_tb is

signal MemWrite1: std_logic:='0';
signal MemWrite2:std_logic:='0';
signal wen: std_logic:='0';
signal MemDst:std_logic:='0';
signal AluSrc1:std_logic:='0';
signal AluSrc2: std_logic:='0';
signal Clk: std_logic:='0';
signal instr1: std_logic_vector(7 downto 0):=(others =>'0');
signal instr2: std_logic_vector(7 downto 0):=(others =>'0');
signal instr3: std_logic_vector(7 downto 0):=(others =>'0');
signal AluRes: std_logic_vector(7 downto 0):=(others =>'0');
signal PSW:std_logic_vector(7 downto 0):=(others=>'0');
signal operand1:std_logic_vector(7 downto 0):=(others =>'0');
signal operand2: std_logic_vector(7 downto 0):=(others =>'0');
 
constant CLK_PERIOD : TIME := 10 ns;

begin

gen_clk: process
         begin
            clk <= '0';
            wait for (CLK_PERIOD/2);
            clk <= '1';
            wait for (CLK_PERIOD/2);
         end process gen_clk;

DUT: entity Work.decode port map
 (MemWrite1=>MemWrite1,
  MemWrite2=>MemWrite2,
  wen=>wen,
  MemDst=>MemDst,
  AluSrc1=>AluSrc1,
  AluSrc2=>AluSrc2,
  Clk=>Clk,
  instr2=>instr2,
  instr3=>instr3,
  AluRes=>AluRes,
  PSW=>PSW,
  operand1=>operand1,
  operand2=>operand2);
  
tb_proc:process
         begin
            wen<='1';
            MemWrite1<='1';
            MemWrite2<='1';
            MemDst<='0'; -- acc
            instr2<=x"05";
            AluSrc1<='0'; --acc
            instr3<=x"00";
            AluSrc2<='0'; --immediate
            AluRes<=x"05";
            PSW<=x"00";
            wait for 20 ns;
 
            wen<='0';
            MemWrite1<='0';
            MemWrite2<='0';
            instr2<=x"E0";
            AluSrc1<='1'; --locatie mem
            instr3<=x"D0";
            AluSrc2<='1'; --locatie mem
            wait for 20 ns;
 
            wen<='0';
            MemWrite1<='0';
            MemWrite2<='0';
            instr2<=x"02";
            AluSrc1<='1'; --locatie mem
            instr3<=x"D0";
            AluSrc2<='1'; --locatie mem
            wait for 20 ns;

            wait ;
        end process;


end Behavioral;
