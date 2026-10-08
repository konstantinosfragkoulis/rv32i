module imem #(
    parameter int SIZE = 256
) (
    input logic [31:0] addr,

    output logic [31:0] rd
);

    logic [31:0] mem [SIZE];

    initial begin
        $readmemh("prog.hex", mem);
    end

    assign rd = mem[addr[$clog2(SIZE)+1 : 2]];

endmodule