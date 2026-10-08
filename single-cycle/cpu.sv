module cpu (
    input logic clk,
    input logic rst
);

    logic [31:0] pc, pc_plus4, pc_target, instr, imm, rd1, rd2, alu_res, mem_rd, mem_wd, load_wd;
    logic [3:0] alu_op, mem_we;
    logic [2:0] reg_write_src, imm_src;
    logic alu_src, reg_write, mem_write, take_branch, can_branch, pc_target_src;

    pc _pc(
        .clk(clk),
        .rst(rst),
        .pc_next(take_branch ? pc_target : pc_plus4),
        .pc(pc)
    );

    assign pc_plus4 = pc + 4;
    assign pc_target = pc_target_src ? {alu_res[31:1], 1'b0} : pc + imm;

    branch _branch(
        .a(rd1),
        .b(rd2),
        .op(instr[6:0]),
        .func3(instr[14:12]),
        .can_branch(can_branch),
        .take_branch(take_branch)
    );

    imem _imem(
        .addr(pc),
        .rd(instr)
    );

    logic [31:0] wd3;

    always_comb begin
        case (reg_write_src)
            3'b000: wd3 = alu_res;
            3'b001: wd3 = load_wd;
            3'b010: wd3 = pc_plus4;
            3'b011: wd3 = imm;
            3'b100: wd3 = pc_target;
            default: wd3 = {32{1'b0}};
        endcase
    end

    regfile _regfile(
        .clk(clk),
        .a1(instr[19:15]),
        .a2(instr[24:20]),
        .a3(instr[11:7]),
        .wd3(wd3),
        .we3(reg_write & ~rst),
        .rd1(rd1),
        .rd2(rd2)
    );

    logic [31:0] alu_b;
    always_comb begin
        case (alu_src)
            1'b0: alu_b = rd2;
            1'b1: alu_b = imm;
        endcase
    end

    alu _alu(
        .a(rd1),
        .b(alu_b),
        .op(alu_op),
        .res(alu_res)
    );

    control _control(
        .op(instr[6:0]),
        .func3(instr[14:12]),
        .func7(instr[31:25]),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .reg_write_src(reg_write_src),
        .imm_src(imm_src),
        .mem_write(mem_write),
        .can_branch(can_branch),
        .pc_target_src(pc_target_src)
    );

    imm_gen _imm_gen(
        .instr(instr),
        .imm_src(imm_src),
        .imm(imm)
    );

    store _store(
        .mem_write(mem_write),
        .addr_lo(alu_res[1:0]),
        .func3(instr[14:12]),
        .rd2(rd2),
        .we(mem_we),
        .wd(mem_wd)
    );

    load _load(
        .addr_lo(alu_res[1:0]),
        .func3(instr[14:12]),
        .mem_rd(mem_rd),
        .wd(load_wd)
    );

    dmem _dmem(
        .addr(alu_res),
        .wd(mem_wd),
        .we(mem_we & {4{~rst}}),
        .clk(clk),
        .rd(mem_rd)
    );

endmodule