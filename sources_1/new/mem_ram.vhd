----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 11:06:15 AM
-- Design Name: 
-- Module Name: mem_ram - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_ram is
  Port (addr1:in std_logic_vector(7 downto 0);
      addr2:in std_logic_vector(7 downto 0);
      addr3:in std_logic_vector(7 downto 0);
      addr4:in std_logic_vector(7 downto 0);
      data_in1:in std_logic_vector(7 downto 0);
      data_in2:in std_logic_vector(7 downto 0);
      data_out1:out std_logic_vector(7 downto 0):=(others=>'0');
      data_out2:out std_logic_vector(7 downto 0):=(others=>'0');
      clk:in std_logic;
      MemWrite1:in std_logic;
      MemWrite2:in std_logic;
      wen:in std_logic );
end mem_ram;

architecture Behavioral of mem_ram is
type ram_type is array(0 to 255) of std_logic_vector(7 downto 0 );
shared variable RAM:ram_type:=(
"00000000",
"00000001",
"00100010",
"10001000",
others =>x"00");

begin

  WRITE_P:process(clk) --scrierea rezultatului si a registrului PSW
        begin
            if rising_edge(clk) then
                if (wen='1') then
                    if (MemWrite1='1') then
                        RAM(conv_integer(addr1)):=data_in1;
                    end if;
                    if (MemWrite2='1') then
                        RAM(conv_integer(addr2)):=data_in2;
                    end if; 
                end if;
            end if;
    end process;  
    
   READ_P:process(clk) --citirea operanzilor
        begin
            if rising_edge(clk) then
                data_out1<=RAM(conv_integer(addr3));
                data_out2<=RAM(conv_integer(addr4));
            end if;
   end process;



end Behavioral;
