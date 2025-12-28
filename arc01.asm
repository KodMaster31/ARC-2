module X1 (
    input wire clk,
    input wire reset,
    output reg out
);

    // ===== REGİSTERLER =====
    reg acc;            // 1-bit accumulator
    reg [1:0] pc;       // 2-bit program counter

    // ===== RAM (4 x 1 bit) =====
    reg ram [0:3];

    // ===== PROGRAM ROM =====
    // OP(2) | ARG(2)
    reg [3:0] program [0:3];

    wire [1:0] opcode;
    wire [1:0] operand;

    assign opcode  = program[pc][3:2];
    assign operand = program[pc][1:0];

    // ===== BAŞLANGIÇ =====
    integer i;
    initial begin
        acc = 0;
        pc  = 0;
        out = 0;

        // RAM başlangıç (A=1, B=1)
        ram[0] = 1;
        ram[1] = 1;
        ram[2] = 0;
        ram[3] = 0;

        // X1 PROGRAMI:
        // LOAD 0
        // AND  1
        // STORE 2
        // OUT
        program[0] = 4'b0000; // LOAD  0
        program[1] = 4'b0101; // AND   1
        program[2] = 4'b1010; // STORE 2
        program[3] = 4'b1100; // OUT
    end

    // ===== FETCH-DECODE-EXECUTE =====
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc  <= 0;
            acc <= 0;
            out <= 0;
        end else begin
            case (opcode)

                2'b00: begin // LOAD
                    acc <= ram[operand];
                end

                2'b01: begin // AND
                    acc <= acc & ram[operand];
                end

                2'b10: begin // STORE
                    ram[operand] <= acc;
                end

                2'b11: begin // OUT
                    out <= acc;
                end

            endcase

            pc <= pc + 1; // PC ilerler
        end
    end

endmodule
