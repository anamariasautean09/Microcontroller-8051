----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:26:59 AM
-- Design Name: 
-- Module Name: uc_tb - Behavioral
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

entity uc_tb is
--  Port ( );
end uc_tb;

architecture Behavioral of uc_tb is

signal opcode: std_logic_vector(7 downto 0):=(others => '0');
signal MemWrite1: std_logic;
signal MemWrite2: std_logic;
signal AluOp:std_logic_vector(3 downto 0);
signal AluSrc1: std_logic;
signal AluSrc2: std_logic;
signal MemDest: std_logic;
signal JmpSrc: std_logic;
signal BrSrc: std_logic;
signal BitOp: std_logic;
signal InvalidOp: std_logic;
signal ALed:std_logic;

begin

DUT : entity Work.unitateComanda port map
(opcode=>opcode,
 MemWrite1=>MemWrite1,
 MemWrite2=>MemWrite2,
 AluOp=>AluOp,
 AluSrc1=>AluSrc1,
 AluSrc2=>AluSrc2,
 MemDest=>MemDest,
 JmpSrc=>JmpSrc,
 BrSrc=>BrSrc,
 BitOp=>BitOp,
 InvalidOp=>InvalidOp,
 ALed=>ALed
  );


tb_proc: process
        begin
            opcode<=x"74";
            wait for 10 ns;
            opcode<=x"25";
            wait for 10 ns;
            opcode<=x"53";
            wait for 10 ns;
            opcode<=x"45";
            wait for 10 ns;
            opcode<=x"B4";
            wait for 10 ns;
            opcode<=x"73";
            wait for 10 ns;
            opcode<=x"C3";
            wait for 10 ns;
            opcode<=x"00";
            wait for 10 ns;
            wait;
        end process;
        
end Behavioral;
