----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:12:45 AM
-- Design Name: 
-- Module Name: decode - Behavioral
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

entity decode is
  Port ( MemWrite1:in std_logic;
       MemWrite2:in std_logic;
       wen:in std_logic;
       MemDst:in std_logic;
       AluSrc1:in std_logic;
       AluSrc2:in std_logic;
       Clk:in std_logic;
       instr2:in std_logic_vector(7 downto 0);
       instr3:in std_logic_vector(7 downto 0);
       AluRes:in std_logic_vector(7 downto 0);
       PSW:in std_logic_vector(7 downto 0);
       operand1:out std_logic_vector(7 downto 0);
       operand2:out std_logic_vector(7 downto 0));
end decode;

architecture Behavioral of decode is

component mem_ram is
 Port (addr1:in std_logic_vector(7 downto 0);
       addr2:in std_logic_vector(7 downto 0);
       addr3:in std_logic_vector(7 downto 0);
       addr4:in std_logic_vector(7 downto 0);
       data_in1:in std_logic_vector(7 downto 0);
       data_in2:in std_logic_vector(7 downto 0);
       data_out1:out std_logic_vector(7 downto 0);
       data_out2:out std_logic_vector(7 downto 0);
       clk:in std_logic;
       MemWrite1:in std_logic;
       MemWrite2:in std_logic;
       wen:in std_logic );
  end component;

signal dest:std_logic_vector(7 downto 0):=(others=> '0');
signal ra1,ra2:std_logic_vector(7 downto 0):=(others=> '0');
signal op1,op2,opp2:std_logic_vector(7 downto 0):=(others=> '0');


begin

DEST_P:process(MemDst,instr2)  --destinatie rezultat
        begin
            if MemDst='0' then 
                dest<=x"E0";  --accumulator
            elsif MemDst='1' then
                dest<=instr2; --o alta locatie de memorie
            end if;
        end process;

SRC1_P:process(AluSrc1, instr2, instr3) --primul operand
        begin
            if AluSrc1='0' then  --primul operand e in acc 
                ra1<=x"E0";  
                ra2<=instr2; 
            elsif AluSrc1='1' then  --primul operand e intr-o alta locatie de memorie
                ra1<=instr2;  --locatie de mem
                ra2<=instr3;
            end if; 
        end process;
   
mem: mem_ram port map 
        (addr1=>dest,
         addr2=>x"D0",-- adresa registrului PSW
         addr3=>ra1,
         addr4=>ra2,
         data_in1=>AluRes,
         data_in2=>PSW,
         data_out1=>op1,
         data_out2=>op2,
         clk=>Clk,
         MemWrite1=>MemWrite1,
         MemWrite2=>MemWrite2,
         wen=>wen);

SRC2_P:process(AluSrc2,AluSrc1,instr2,instr3,op2) --al doilea operand
        begin
            if AluSrc2='0' then --al doilea operand e immediate
                if AluSrc1='0' then --primul operand e in acc
                    opp2<=instr2; --immediate e in al doilea byte
                elsif AluSrc1='1' then   --primul operand e intr-o alta locatie de memorie
                    opp2<=instr3; -- immediate e in al treilea byte
                end if;
            elsif AluSrc2='1' then --al doilea operand e intr-o locatie de memorie
                opp2<=op2; --citirea din memorie
            end if;
        end process;
    
operand1<=op1;
operand2<=opp2;


end Behavioral;
