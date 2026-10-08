module dmem #(
    parameter int SIZE = 1024
) (
    input logic [31:0] addr,
    input logic [31:0] wd,
    input logic [3:0] we,
    input logic clk,

    output logic [31:0] rd
);

    logic [31:0] mem [SIZE];
    logic [$clog2(SIZE)-1 : 0] idx;

    assign idx = addr[$clog2(SIZE)+1 : 2];
    assign rd = mem[idx];

    always_ff @(posedge clk) begin
        if(we[0]) mem[idx][7:0] <= wd[7:0];
        if(we[1]) mem[idx][15:8] <= wd[15:8];
        if(we[2]) mem[idx][23:16] <= wd[23:16];
        if(we[3]) mem[idx][31:24] <= wd[31:24];
    end

endmodule