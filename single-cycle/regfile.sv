module regfile import rv32i_pkg::*; (
    input logic [4:0] a1,
    input logic [4:0] a2,
    input logic [4:0] a3,
    input logic [31:0] wd3,
    input logic clk,
    input logic we3,

    output logic [31:0] rd1,
    output logic [31:0] rd2
);

    logic [31:0] regs [32];

    assign rd1 = (a1 != 0) ? regs[a1] : 0;
    assign rd2 = (a2 != 0) ? regs[a2] : 0;

    always_ff @(posedge clk) begin
        if (we3) regs[a3] <= wd3;
    end

endmodule