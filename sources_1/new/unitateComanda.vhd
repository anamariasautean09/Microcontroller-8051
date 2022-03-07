----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:16:41 AM
-- Design Name: 
-- Module Name: unitateComanda - Behavioral
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

entity unitateComanda is
 Port (opcode:in std_logic_vector(7 downto 0);
      MemWrite1:out std_logic;
      MemWrite2:out std_logic;
      AluOp:out std_logic_vector(3 downto 0);
      AluSrc1:out std_logic;
      AluSrc2:out std_logic;
      MemDest:out std_logic;
      JmpSrc:out std_logic;
      BrSrc:out std_logic;
      BitOp:out std_logic;
      InvalidOp:out std_logic;
      Aled:out std_logic);
end unitateComanda;

architecture Behavioral of unitateComanda is

begin

process(opcode)
    begin   
    --initializarea semnalelor
        MemWrite1<='0';
        MemWrite2<='0';
        AluOp<="0000";
        AluSrc1<='0';
        AluSrc2<='0';
        MemDest<='0';
        JmpSrc<='0';
        BrSrc<='0';
        BitOp<='0';
        InvalidOp<='0';
        ALed<='0';

        case opcode is
            -- aprindere led
            when x"11" => ALed<='1';
            
            --CJNE A,#DATA,reladdr
            when x"B4" => BrSrc<='1';
                          AluOp<="0010" ; --scadere
            
            --AJMP page0 address             
            when x"01" => JmpSrc<='1';   
            
            --INC Direct
            when x"05" => AluOp<="0110";
                          MemWrite1<='1';
                          MemWrite2<='1';
                          AluSrc1<='1';
                          MemDest<='1';
            --DEC Direct
            when x"15" => AluOp<="0111";
                          MemWrite1<='1';
                          MemWrite2<='1';
                          AluSrc1<='1';
                          MemDest<='1';
                          
            --ADD A, #DATA
            when x"24" => AluOp<="0001"; --adunare
                          MemWrite1<='1'; --rezultat
                          MemWrite2<='1'; --reg PSW
                   
            --ADD A, Direct              
            when x"25" => AluOp<="0001"; --adunare
                          AluSrc2<='1'; -- locatie de mem
                          MemWrite1<='1';
                          MemWrite2<='1';
                      
            --SUB A, #DATA              
            when x"94" => AluOp<="0010"; --scadere
                          MemWrite1<='1';
                          MemWrite2<='1';
                      
            --SUB A, Direct
            when x"95" => AluOp<="0010"; --scadere
                          AluSrc2<='1'; -- locatie de mem
                          MemWrite1<='1';
                          MemWrite2<='1';
                      
            --ANL A, #DATA
            when x"54" => AluOp<="0011"; --and logic
                          MemWrite1<='1';
                      
            --ANL A, Direct
            when x"55" => AluOp<="0011"; --and logic
                          AluSrc2<='1';  --locatie de mem
                          MemWrite1<='1';
                        
            --ANL Direct, #Data
            when x"53" => AluOp<="0011"; --and logic
                          AluSrc1<='1'; --locatie de mem
                          MemDest<='1'; --locatie de mem
                          MemWrite1<='1';
                    
            --ORL A, #DATA
            when x"44" => AluOp<="0100"; --or logic
                          MemWrite1<='1';
            
            --ORL A, Direct
            when x"45" => AluOp<="0100"; --or logic
                          AluSrc2<='1';  --locatie de mem
                          MemWrite1<='1';
                                
            --ORL Direct, #Data
            when x"43" => AluOp<="0100"; --or logic
                          AluSrc1<='1'; --locatie de mem
                          MemDest<='1'; --locatie de mem
                          MemWrite1<='1';
                      
            --CLR C
            when x"C3" =>  BitOp<='1'; 
                           AluOp<="0101"; --clear carry
                           MemWrite2<='1';
            
            --MOV A, #DATA
            when x"74" => AluOp<="0000"; --mov op
                          MemWrite1<='1';
                      
            --MOV A, Direct
            when x"E5" => AluOp<="0000";
                          AluSrc2<='1';
                          MemWrite1<='1';
                      
            --MOV  Direct, #Data
            when x"75" => AluOp<="0000";
                          MemDest<='1';
                          MemWrite1<='1';
                          AluSrc1<='1';
                          
            --MOV Direct, A
            when x"F5" => AluOp<="1000";
                          MemDest<='1';
                          AluSrc1<='0';
                          MemWrite1<='1';
                          
            --RL 
            when x"23" =>AluOp<="1001";
                         MemDest<='0';
                         MemWrite1<='1';
            --RR 
            when x"03" =>AluOp<="1010";
                         MemDest<='0';
                         MemWrite1<='1';
                          
                          
                      
            when others => InvalidOp<='1'  ;
        end case;
end process;

end Behavioral;
