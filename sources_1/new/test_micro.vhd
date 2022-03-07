----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:23:15 AM
-- Design Name: 
-- Module Name: test_micro - Behavioral
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

entity test_micro is
 Port (clk : in STD_LOGIC;
      btn : in STD_LOGIC_VECTOR (4 downto 0);
      sw : in STD_LOGIC_VECTOR (15 downto 0);
      led : out STD_LOGIC_VECTOR (15 downto 0);
      an : out STD_LOGIC_VECTOR (3 downto 0);
      cat : out STD_LOGIC_VECTOR (6 downto 0) );
end test_micro;

architecture Behavioral of test_micro is

signal jmpaddr:std_logic_vector(15 downto 0):=(others=>'0');
signal jmpsrc:std_logic:='0';
signal braddr:std_logic_vector(15 downto 0):=(others=>'0');
signal brsrc:std_logic:='0';
signal instr1:std_logic_vector(7 downto 0):=(others=>'0');
signal instr2:std_logic_vector(7 downto 0):=(others=>'0');
signal instr3:std_logic_vector(7 downto 0):=(others=>'0');
signal next_instr:std_logic_vector(15 downto 0):=(others=>'0');
signal en:std_logic;
signal enRes:std_logic:='0';
signal pcout:std_logic_vector(15 downto 0):=(others=>'0');

signal MemWrite1:std_logic:='0';
signal MemWrite2:std_logic:='0';
signal wen:std_logic;
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
signal branch:std_logic:='0';
signal ALed:std_logic:='0';

signal Zero:std_logic:='0';
signal dout:std_logic_vector(15 downto 0);


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
 en=>wen,
 enRes=>enRes,
 clk=>clk,
 pcout=>pcout
);

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
  operand2=>operand2
  );
  
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
 ALed=>ALed
  );

DUT_execute: entity Work.execute port map
(next_instr=>next_instr,
 rd1=>operand1,
 rd2=>operand2,
 instr3=>instr3,
 AluOp=>AluOp,
 branchAddr=>braddr,
 psw=>PSW,
 AluResult=>AluRes,
 Zero=>Zero
 );
 
 
DUT_MPG1: entity Work.MPG port map
    (wen,btn(1),clk);
    
DUT_MPG2: entity Work.MPG port map
    (enRes,btn(2),clk);
    
    
DUT_SSD: entity Work.SSD port map
(clk=>clk,
digit0=>dout(3 downto 0),
digit1=>dout(7 downto 4),
digit2=>dout(11 downto 8),
digit3=>dout(15 downto 12),
an=>an,
cat=>cat);

jmpaddr<=instr1(7 downto 5) & pcout(12 downto 8) & instr2;
brsrc<=branch and (not Zero);
 
AFISARE: process(sw(2 downto 0),instr1,instr2,instr3,next_instr,operand1,operand2,AluRes,PSW,braddr,jmpaddr)
         begin
            case sw(2 downto 0) is
                 when "000" => dout<=instr1 & instr2;
                 when "001" => dout<=next_instr;
                 when "010" => dout<=x"00" & operand1;
                 when "011" => dout<=x"00" & operand2 ;
                 when "100" => dout<=x"00" & Alures ;
                 when "101" => dout<=x"00" & PSW  ;
                 when "110" =>dout <=braddr;
                 when "111" => dout<=jmpaddr;
                 when others => dout<=x"0000";
            end case;
         end process;
   
led(15 downto 8)<=instr3;
led(0)<=InvalidOp;
led(1)<=ALed;

end Behavioral;
