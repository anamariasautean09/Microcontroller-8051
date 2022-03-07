----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2021 04:32:25 AM
-- Design Name: 
-- Module Name: MPG - Behavioral
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

entity MPG is
    Port ( enable : out STD_LOGIC;
           input : in STD_LOGIC;
           clk : in STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal count_int : std_logic_vector(15 downto 0) :=x"0000";
signal Q1 : std_logic;
signal Q2 : std_logic;
signal Q3 : std_logic;

begin

enable <= Q2 AND (not Q3);

process(clk)
begin 
    if clk'event and clk = '1' then
        if count_int(15 downto 0) = "1111111111111111" then
            Q1 <= input;
        end if;
    end if;
end process;

process(clk)
begin 
    if clk'event and clk='1' then
        Q2<=Q1;
        Q3<=Q2;
    end if;
end process;


end Behavioral;
