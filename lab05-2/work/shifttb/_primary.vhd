library verilog;
use verilog.vl_types.all;
entity shifttb is
    generic(
        R0              : vl_logic_vector;
        R1              : vl_logic_vector;
        R2              : vl_logic_vector;
        R3              : vl_logic_vector;
        R4              : vl_logic_vector;
        R5              : vl_logic_vector;
        R6              : vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of R0 : constant is 4;
    attribute mti_svvh_generic_type of R1 : constant is 4;
    attribute mti_svvh_generic_type of R2 : constant is 4;
    attribute mti_svvh_generic_type of R3 : constant is 4;
    attribute mti_svvh_generic_type of R4 : constant is 4;
    attribute mti_svvh_generic_type of R5 : constant is 4;
    attribute mti_svvh_generic_type of R6 : constant is 4;
end shifttb;
