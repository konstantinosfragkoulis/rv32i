module pc (
    input logic clk,
    input logic rst,
    input logic [31:0] pc_next,

    output logic [31:0] pc
);

    always_ff @(posedge clk) begin
        pc <= rst ? 0 : pc_next;
    end

endmodule