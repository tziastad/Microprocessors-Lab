library verilog;
use verilog.vl_types.all;
entity registerfileA is
    generic(
        R3              : vl_logic_vector;
        R15             : vl_logic_vector;
        R14             : vl_logic_vector;
        R13             : vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of R3 : constant is 4;
    attribute mti_svvh_generic_type of R15 : constant is 4;
    attribute mti_svvh_generic_type of R14 : constant is 4;
    attribute mti_svvh_generic_type of R13 : constant is 4;
end registerfileA;
