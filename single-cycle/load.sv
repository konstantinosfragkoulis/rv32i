module load (
    input logic [1:0] addr_lo,
    input logic [2:0] func3,
    input logic [31:0] mem_rd,

    output logic [31:0] wd
);

    always_comb begin

        wd = mem_rd;
        
        case (func3)
            3'b000: begin
                wd = {{24{mem_rd[8*addr_lo + 7]}}, mem_rd[8*addr_lo +: 8]};
            end
            3'b001: begin
                wd = {{16{mem_rd[16*addr_lo[1] + 15]}}, mem_rd[16*addr_lo[1] +: 16]};
            end
            3'b010: begin
                wd = mem_rd;
            end
            3'b100: begin
                wd = {{24{1'b0}}, mem_rd[8*addr_lo +: 8]};
            end
            3'b101: begin
                wd = {{16{1'b0}}, mem_rd[16*addr_lo[1] +: 16]};
            end
        endcase
    end

endmodule