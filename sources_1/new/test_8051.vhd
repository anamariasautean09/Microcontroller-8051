----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:18:42 AM
-- Design Name: 
-- Module Name: test_8051 - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_8051 is
 Port (clk : in STD_LOGIC;
      en:in std_logic;
      wen:in std_logic;
      instruction:out std_logic_vector(23 downto 0);
      next_instruction:out std_logic_vector(15 downto 0);
      opp1:out std_logic_vector(7 downto 0);
      opp2:out std_logic_vector(7 downto 0);
      result:out std_logic_vector(7 downto 0);
      psw_reg:out std_logic_vector(7 downto 0);
      branch_addr:out std_logic_vector(15 downto 0);
      jmp_address:out std_logic_vector(15 downto 0));      
end test_8051;

architecture Behavioral of test_8051 is

signal jmpaddr:std_logic_vector(15 downto 0):=(others=>'0');
signal jmpsrc:std_logic:='0';
signal braddr:std_logic_vector(15 downto 0):=(others=>'0');
signal brsrc:std_logic:='0';
signal instr1:std_logic_vector(7 downto 0):=(others=>'0');
signal instr2:std_logic_vector(7 downto 0):=(others=>'0');
signal instr3:std_logic_vector(7 downto 0):=(others=>'0');
signal next_instr:std_logic_vector(15 downto 0):=(others=>'0');

signal enRes:std_logic:='0';
signal pcout:std_logic_vector(15 downto 0):=(others=>'0');

signal MemWrite1:std_logic:='0';
signal MemWrite2:std_logic:='0';
signal MemDst:std_logic:='0';
signal AluSrc1:std_logic:='0';
signal AluSrc2:std_logic:='0';
signal AluRes:std_logic_vector(7 downto 0):=(others=>'0');
signal PSW:std_logic_vector(7 downto 0):=(others=>'0');
signal operand1:std_logic_vector(7 downto 0):=(others=>'0');
signal operand2:std_logic_vector(7 downto 0):=(others=>'0');

signal AluOp:std_logic_vector(3 downto 0):=(others=>'0');
signal BitOp:std_logic:='0';
signal InvalidOp:std_logic:='0';
signal ALed:std_logic:='0';
signal branch:std_logic:='0';

signal Zero:std_logic:='0';


begin

DUT_instr_fetch: entity Work.InstrFetch port map
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

DUT_decode: entity Work.decode port map
( MemWrite1=>MemWrite1,
  MemWrite2=>MemWrite2,
  wen=>wen,
  MemDst=>MemDst,
  AluSrc1=>AluSrc1,
  AluSrc2=>AluSrc2,
  Clk=>clk,
  instr2=>instr2,
  instr3=>instr3,
  AluRes=>AluRes,
  PSW=>PSW,
  operand1=>operand1,
  operand2=>operand2);

DUT_unitate_com: entity Work.unitateComanda port map
(opcode=>instr1,
 MemWrite1=>MemWrite1,
 MemWrite2=>MemWrite2,
 AluOp=>AluOp,
 AluSrc1=>AluSrc1,
 AluSrc2=>AluSrc2,
 MemDest=>MemDst,
 JmpSrc=>jmpsrc,
 BrSrc=>branch,
 BitOp=>BitOp,
 InvalidOp=>InvalidOp,
 ALed=>ALed );
 
DUT_execute: entity Work.execute port map
 (next_instr=>next_instr,
  rd1=>operand1,
  rd2=>operand2,
  instr3=>instr3,
  AluOp=>AluOp,
  branchAddr=>braddr,
  psw=>PSW,
  AluResult=>AluRes,
  Zero=>Zero);
  
jmpaddr<=instr1(7 downto 5) & pcout(12 downto 8) & instr2;
 
brsrc<=branch and (not Zero);
instruction<=instr1 &instr2 &instr3;
next_instruction<=next_instr;
opp1<=operand1;
opp2<=operand2;
result<=AluRes;
psw_reg<=PSW;
branch_addr<=braddr;
jmp_address<=jmpaddr;
  
   
end Behavioral;
