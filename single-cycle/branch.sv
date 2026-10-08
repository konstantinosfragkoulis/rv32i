module branch import rv32i_pkg::*; (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [6:0] op,
    input logic [2:0] func3,
    input logic can_branch,

    output logic take_branch
);

    always_comb begin
        take_branch = 1'b0;

        if (can_branch) begin
            case (func3)
                3'b000: take_branch = (a == b);
                3'b001: take_branch = (a != b);
                3'b100: take_branch = ($signed(a) < $signed(b));
                3'b101: take_branch = ($signed(a) >= $signed(b));
                3'b110: take_branch = (a < b);
                3'b111: take_branch = (a >= b);
            endcase

            if (op == OP_JAL) take_branch = 1'b1;
            if (op == OP_JALR) take_branch = 1'b1;
        end
    end

endmodule