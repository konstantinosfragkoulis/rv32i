module imm_gen (
    input logic [31:0] instr,
    input logic [2:0] imm_src,

    output logic [31:0] imm
);

    always_comb begin
        case (imm_src)
            3'b000: imm = {{20{instr[31]}}, instr[31:20]};
            3'b001: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            3'b010: imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
            3'b011: imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            3'b100: imm = {instr[31:12], {12{1'b0}}};
            default: imm = {32{1'b0}};
        endcase
    end

endmodule