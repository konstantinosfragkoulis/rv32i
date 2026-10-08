module store (
    input logic mem_write,
    input logic [1:0] addr_lo,
    input logic [2:0] func3,
    input logic [31:0] rd2,

    output logic [3:0] we,
    output logic [31:0] wd
);

    always_comb begin
        we = 4'b0000;
        wd = rd2;

        case (func3)
            3'b000: begin
                we = 4'b0001 << addr_lo;
                wd = {4{rd2[7:0]}};
            end
            3'b001: begin
                if (addr_lo[0] == 0) begin
                    we = 4'b0011 << addr_lo;
                end
                wd = {2{rd2[15:0]}};
            end
            3'b010: begin
                if (addr_lo == 2'b00) we = 4'b1111;
            end
        endcase

        we = we & {4{mem_write}};
    end

endmodule