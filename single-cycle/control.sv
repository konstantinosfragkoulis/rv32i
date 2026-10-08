module control import rv32i_pkg::*; (
    input logic [6:0] op,
    input logic [2:0] func3,
    input logic [6:0] func7,

    output logic [3:0] alu_op,
    output logic alu_src,
    output logic reg_write,
    output logic [2:0] reg_write_src,
    output logic [2:0] imm_src,
    output logic mem_write,
    output logic can_branch,
    output logic pc_target_src
);

    always_comb begin
        alu_op = ALU_ADD;
        alu_src = 1'b0;
        reg_write = 1'b0;
        reg_write_src = 3'b000;
        imm_src = 3'b000;
        mem_write = 1'b0;
        can_branch = 1'b0;
        pc_target_src = 1'b0;
        case (op)
            OP_R: begin
                alu_op = {func7[5], func3};
                alu_src = 1'b0;
                reg_write = 1'b1;
                reg_write_src = 3'b000;
                imm_src = 3'b000;
                mem_write = 1'b0;
                can_branch = 1'b0;
                pc_target_src = 1'b0;
            end
            OP_IMM: begin
                alu_op = {((func3 == 3'b101) & func7[5]), func3};
                alu_src = 1'b1;
                reg_write = 1'b1;
                reg_write_src = 3'b000;
                imm_src = 3'b000;
                mem_write = 1'b0;
                can_branch = 1'b0;
                pc_target_src = 1'b0;
            end
            OP_S: begin
                alu_op = ALU_ADD;
                alu_src = 1'b1;
                reg_write = 1'b0;
                reg_write_src = 3'b000;
                imm_src = 3'b001;
                mem_write = 1'b1;
                can_branch = 1'b0;
                pc_target_src = 1'b0;
            end
            OP_LOAD: begin
                alu_op = ALU_ADD;
                alu_src = 1'b1;
                reg_write = 1'b1;
                reg_write_src = 3'b001;
                imm_src = 3'b000;
                mem_write = 1'b0;
                can_branch = 1'b0;
                pc_target_src = 1'b0;
            end
            OP_B: begin
                alu_op = ALU_ADD;
                alu_src = 1'b0;
                reg_write = 1'b0;
                reg_write_src = 3'b000;
                imm_src = 3'b010;
                mem_write = 1'b0;
                can_branch = 1'b1;
                pc_target_src = 1'b0;
            end
            OP_JAL: begin
                alu_op = ALU_ADD;
                alu_src = 1'b0;
                reg_write = 1'b1;
                reg_write_src = 3'b010;
                imm_src = 3'b011;
                mem_write = 1'b0;
                can_branch = 1'b1;
                pc_target_src = 1'b0;
            end
            OP_JALR: begin
                alu_op = ALU_ADD;
                alu_src = 1'b1;
                reg_write = 1'b1;
                reg_write_src = 3'b010;
                imm_src = 3'b000;
                mem_write = 1'b0;
                can_branch = 1'b1;
                pc_target_src = 1'b1;
            end
            OP_LUI: begin
                alu_op = ALU_ADD;
                alu_src = 1'b0;
                reg_write = 1'b1;
                reg_write_src = 3'b011;
                imm_src = 3'b100;
                mem_write = 1'b0;
                can_branch = 1'b0;
                pc_target_src = 1'b0;
            end
            OP_AUIPC: begin
                alu_op = ALU_ADD;
                alu_src = 1'b0;
                reg_write = 1'b1;
                reg_write_src = 3'b100;
                imm_src = 3'b100;
                mem_write = 1'b0;
                can_branch = 1'b0;
                pc_target_src = 1'b0;
            end
        endcase
    end

endmodule