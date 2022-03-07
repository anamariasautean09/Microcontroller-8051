----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:10:37 AM
-- Design Name: 
-- Module Name: execute - Behavioral
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

entity execute is
 Port ( next_instr:in std_logic_vector(15 downto 0);
       rd1:in std_logic_vector(7 downto 0);
       rd2:in std_logic_vector(7 downto 0);
       instr3:in std_logic_vector(7 downto 0);
       AluOp:in std_logic_vector(3 downto 0);
       branchAddr:out std_logic_vector(15 downto 0);
       psw:out std_logic_vector(7 downto 0);
       AluResult:out std_logic_vector(7 downto 0);
       Zero:out std_logic);
end execute;

architecture Behavioral of execute is

signal AluRes:std_logic_vector(7 downto 0):=x"00";
signal imm:std_logic_vector(15 downto 0);
signal psw_aux:std_logic_vector(7 downto 0):=(others=>'0');
signal sum:std_logic_vector(8 downto 0):=(others=>'0');
signal semisum:std_logic_vector(4 downto 0):=(others=>'0');
signal s:std_logic;

begin

IMM_EXT: process(instr3)
         begin
            if (instr3(7)='1') then
                imm<=x"FF" & instr3;
            else 
                imm<=x"00" & instr3;
            end if;
         end process;
         
branchAddr<=next_instr + imm;

EX_P:process(AluOp, rd1, rd2,sum,semisum, s)
        begin
            case AluOp is
                --mov operation
                when "0000" =>AluRes<=rd2; 
                when "1000" =>AluRes<=rd1;
                
                 --adunare              
                when "0001" =>AluRes<=rd1+rd2;
                             
                             sum<=conv_std_logic_vector((conv_integer(rd1)+conv_integer(rd2)),9); --carry
                             semisum<=conv_std_logic_vector((conv_integer(rd1(3 downto 0))
                                                +conv_integer(rd2(3 downto 0))),5);  --aux carry
                             psw_aux(7 downto 6)<=sum(8) & semisum(4);
                             psw_aux(2)<=sum(8) xor sum(7); --overflow
                --scadere
                when "0010" =>AluRes<=rd1-rd2;
                             --carry
                             if (conv_integer(rd1)-conv_integer(rd2)<0) then
                                    psw_aux(7)<='1';
                             end if;
                             --auxiliary carry
                             if (conv_integer(rd1(3 downto 0))-conv_integer(rd2(3 downto 0))<0) then
                                    psw_aux(6)<='1';
                             end if;
                             --overflow
                             if (rd1(7)/=rd2(7) and AluRes(7)=rd2(7)) then
                                    psw_aux(2)<='1';
                             end if;
               
                             
                --and logic         
                when "0011" =>AluRes<=rd1 and rd2;
            
                --or logic
                when "0100" =>AluRes<=rd1 or rd2;
                
                 --cler carry
                when "0101" =>AluRes<=x"00";  
                             psw_aux(7)<='0';
                
                --inc 
                when "0110" =>AluRes<=rd1 + x"01";
                             if (rd1=x"FF") then
                                psw_aux(7)<='1';
                             end if;
                             
                --dec
                when "0111" =>AluRes<=rd1 - x"01";
                             if (rd1=x"00") then
                                psw_aux(7)<='1';
                             end if;
                   
                --rotate left
                when "1001" =>  s<=rd1(7);
                                AluRes<=rd1(6 downto 0) & s;
                   
                --rotate right
                when "1010" =>  s<=rd1(0);
                                AluRes<=s & rd1(7 downto 1);
                             
                 
                
            
                when others => AluRes<=x"00";
            end case;
       end process;
   
Zero<='1' when AluRes=x"00" else '0';
AluResult<=AluRes;
psw<=psw_aux;

end Behavioral;
