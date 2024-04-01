library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- NOTE: This implementation of ROMEN_HOLD_TIME can only be used with Altera devices that support the LCELL primitive.
entity ROMEN_HOLD_TIME is
    port (
        PHI_0 : in std_logic;

        DELAYED_PHI_0 : out std_logic
    );
end ROMEN_HOLD_TIME;

architecture RTL of ROMEN_HOLD_TIME is
    constant NUM_LCELLS : positive := 7;

    component LCELL
        port (
            A_IN : in std_logic;
            A_OUT : out std_logic
        );
    end component;

    signal PHI_0_DELAY : std_logic_vector((NUM_LCELLS-1) downto 0);
begin
    INITIAL_DELAY : LCELL port map(
        A_IN => PHI_0,
        A_OUT => PHI_0_DELAY(0)
    );

    g_GENERATE_DELAY: for i in 0 to (NUM_LCELLS-2) generate
        DELAY : LCELL port map(
            A_IN => PHI_0_DELAY(i),
            A_OUT => PHI_0_DELAY(i+1)
        );
    end generate g_GENERATE_DELAY;

    DELAYED_PHI_0 <= PHI_0_DELAY(NUM_LCELLS-1);
end RTL;
