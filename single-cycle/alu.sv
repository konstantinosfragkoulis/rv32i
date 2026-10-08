module alu import rv32i_pkg::*; (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] op,

    output logic [31:0] res
);

    always_comb begin
        case (op)
            ALU_ADD: res = a + b;
            ALU_SUB: res = a - b;
            ALU_SLL: res = a << b[4:0];
            ALU_SLT: res = {31'b0, $signed(a) < $signed(b)};
            ALU_SLTU: res = {31'b0, a < b};
            ALU_XOR: res = a ^ b;
            ALU_SRL: res = a >> b[4:0];
            ALU_SRA: res = $signed(a) >>> b[4:0];
            ALU_OR: res = a | b;
            ALU_AND: res = a & b;
            default: res = 32'b0;
        endcase
    end

endmodule