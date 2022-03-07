----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:08:21 AM
-- Design Name: 
-- Module Name: InstrFetch - Behavioral
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

entity InstrFetch is
 Port (  jmpaddr:in std_logic_vector(15 downto 0);
        jmpsrc:in std_logic;
        braddr:in std_logic_vector(15 downto 0);
        brsrc:in std_logic;
        instr1:out std_logic_vector(7 downto 0);
        instr2:out std_logic_vector(7 downto 0);
        instr3:out std_logic_vector(7 downto 0);
        next_instr:out std_logic_vector(15 downto 0);
        en:in std_logic;
        enRes:in std_logic;
        clk:in std_logic;
        pcout:out std_logic_vector(15 downto 0));
end InstrFetch;

architecture Behavioral of InstrFetch is
signal PC:std_logic_vector(15 downto 0):=(others=> '0');
signal pc1:std_logic_vector(15 downto 0):=(others=> '0'); --jmp
signal pc2:std_logic_vector(15 downto 0):=(others=> '0'); --branch


signal data8:std_logic_vector(7 downto 0):=(others=> '0');
signal data8_1:std_logic_vector(7 downto 0):=(others=> '0');
signal data8_2:std_logic_vector(7 downto 0):=(others=> '0');

signal i:natural:=0;

type ROM_type is array(0 to 63) of std_logic_vector(7 downto 0);
signal rom:ROM_type:=(
x"75",  --mov (01),0
x"01",
x"00",
x"75", --mov (02), 0
x"02",
x"00",
x"E5",  --mov a,(02)
x"02",
x"25", --add a,(01)
x"01",
x"F5",  --mov (02),a
x"02",
x"05",  --inc (01)
x"01",
x"E5", --mov a ,(01)
x"01",
x"B4",  --cjne a, 6 ,-12
x"06",
x"F3",
x"11",      -- aprindere led




others=> "00000000");

begin

PC_GEN:process(clk,enRes,en,pc2)
        begin
             if enRes='1' then
                PC<=x"0000";
             elsif rising_edge(clk) then
                if en='1' then
                     PC<=pc2;
                end if;
             end if;
        end process;
     
data8<=rom(conv_integer(PC));
instr1<=data8;  --opcode

data8_1<=rom(conv_integer(PC+1));
data8_2<=rom(conv_integer(PC+2));

INSTRUCTION_TYPE: process(data8)  --numarul de bytes al instructiunii in functie de opcode
            begin 
                if (data8=x"C3" or data8=x"11" or data8=x"23" or data8=x"03")then  --one byte 
                    i<=1;
                elsif (data8=x"53" or data8=x"B4" or data8=x"75" or data8=x"43") then --3 bytes
                    i<=3;
                else   --2 bytes
                    i<=2;  
                end if;
            end process;

JUMP_PC: process(jmpsrc,jmpaddr,i,PC) --adresa de jump
        begin
            if jmpsrc='1' then
                pc1<=jmpaddr;
            elsif jmpsrc='0'  then
                pc1<=PC+i;  
            end if;
        end process;

BRANCH_PC:process(brsrc,braddr,pc1) --adresa de branch
        begin
            if brsrc='1' then
                pc2<=braddr;
            elsif brsrc='0' then
                pc2<=pc1;
            end if;
        end process;

INSTRUCTION_GEN:process(data8_1,data8_2,i)  --genereaza instructiunea 
            begin
                case i is
                    when 1 =>   instr2<=x"00";
                                instr3<=x"00";
                    when 2  =>  instr2<=data8_1;
                                instr3<=x"00";
                    when 3  =>  instr2<=data8_1;
                                instr3<=data8_2;
                    when others => instr2<=x"00";
                                   instr3<=x"00";
                end case;
            end process;
            
next_instr<=PC+i; 
pcout<=PC; --adresa instructiunii curente


end Behavioral;
