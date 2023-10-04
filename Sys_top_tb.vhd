library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Sys_top_tb is
end;

architecture bench of Sys_top_tb is

  component Sys_top
  	port (
  	  clk_st                 : in  std_logic;  
  	  rst_in                : in  std_logic; 
--      proc_beat			    : out std_logic; 
  
   st_pin1                  : inout STD_LOGIC;
   st_pin2                  : inout STD_LOGIC;
   st_pin3                 : inout STD_LOGIC;
   st_pin4                  : inout STD_LOGIC;
   st_pin5                  : inout STD_LOGIC;
   st_pin6                  : inout STD_LOGIC;
   st_pin7                  : inout STD_LOGIC;
   st_pin8                  : inout STD_LOGIC
      );
  end component;

  signal clk_st    : std_logic := '1';
  signal rst_in   : std_logic := '0';
--  signal proc_beat: std_logic;
  signal st_pin1  : std_logic;
  signal st_pin2  : std_logic;
  signal st_pin3  : std_logic;
  signal st_pin4  : std_logic;
  signal st_pin5  : std_logic;
  signal st_pin6  : std_logic;
  signal st_pin7  : std_logic;
  signal st_pin8  : std_logic;
begin

  uut: Sys_top port map ( clk_st     => clk_st,
                          rst_in    => rst_in,
--                          proc_beat => proc_beat,
                          st_pin1  => st_pin1,
                          st_pin2  => st_pin2,
                          st_pin3  => st_pin3,
                          st_pin4  => st_pin4,
                          st_pin5  => st_pin5,
                          st_pin6  => st_pin6,
                          st_pin7  => st_pin7,
                          st_pin8  => st_pin8
                          
                        );

  stimulus: process(clk_st)
  begin
    
clk_st <= not clk_st after 5 ns;

  end process;
  rst_in <= '1' after 20 ns;

end;