----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:40:33 AM
-- Design Name: 
-- Module Name: exec_tb - Behavioral
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

entity exec_tb is
--  Port ( );
end exec_tb;

architecture Behavioral of exec_tb is

signal next_instr: std_logic_vector(15 downto 0):=(others=>'0');
signal rd1:std_logic_vector(7 downto 0):=(others=>'0');
signal rd2: std_logic_vector(7 downto 0):=(others=>'0');
signal AluOp: std_logic_vector(3 downto 0):=(others=>'0');
signal branchAddr: std_logic_vector(15 downto 0);
signal psw: std_logic_vector(7 downto 0);
signal AluResult: std_logic_vector(7 downto 0);
signal Zero: std_logic;
signal instr3: std_logic_vector(7 downto 0):=(others=>'0');

begin

DUT: entity Work.execute port map
(next_instr=>next_instr,
 rd1=>rd1,
 rd2=>rd2,
 instr3=>instr3,
 AluOp=>AluOp,
 branchAddr=>branchAddr,
 psw=>psw,
 AluResult=>AluResult,
 Zero=>Zero
 );

tb_proc: process
         begin
            next_instr<=x"0001";
            rd1<=x"02";
            rd2<=x"02";
            AluOp<="0010"; --scadere
            wait for 10 ns;

            next_instr<=x"0002";
            rd1<=x"02";
            rd2<=x"02";
            AluOp<="0001"; --adunare
            wait for 10 ns;
            wait;
    
        end process;

end Behavioral;
