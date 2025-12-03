library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sender is
    port (
        clk: in std_logic;
        prime1_receiver, prime2_receiver: buffer integer;
        outCurr: out character;
        outputEncrypt: out character;
        outputDecrypt: out character
    );
end entity Sender;

architecture rtl of Sender is
    component Receiver is
        port (
            clk: in std_logic;
            input: in string (1 to 19);
            prime1_receiver, prime2_receiver: buffer integer;
            outCurr: out character;
            outputEncrypt: out character;
            outputDecrypt: out character
        );
    end component Receiver;

    signal input_tb: string(1 to 19) := "B C D E F G H I J K";
begin
    Receiver1: Receiver port map (
        clk => clk, 
        input => input_tb, 
        prime1_receiver => prime1_receiver, 
        prime2_receiver => prime2_receiver, 
        outCurr => outCurr,
        outputEncrypt => outputEncrypt,
        outputDecrypt => outputDecrypt
    );
end architecture rtl;