module X1_2B_FINAL (
    input  wire      clk,
    input  wire      reset,
    output reg [1:0] out
);

    // ===== REGISTERS =====
    reg [1:0] acc;
    reg [1:0] pc;
    reg [1:0] pc_next;
    reg       Z;
    reg       halt;

    // ===== MEMORY =====
    reg [1:0] ram [0:3];
    reg [3:0] rom [0:3];

    wire [1:0] opcode  = rom[pc][3:2];
    wire [1:0] operand = rom[pc][1:0];

    integer i;

    // ===== RESET & EXECUTION =====
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            acc  <= 0;
            pc   <= 0;
            out  <= 0;
            Z    <= 0;
            halt <= 0;

            for (i = 0; i < 4; i = i + 1)
                ram[i] <= 0;

            // ===== DEMO PROGRAM =====
            // RAM[0] = 2
            // RAM[1] = 1
            // LOOP: LOAD 0
            // ADD  1
            // CMP  0
            // JZ   3
            // OUT

            ram[0] <= 2;
            ram[1] <= 1;

            rom[0] <= 4'b0000; // LOAD 0
            rom[1] <= 4'b0101; // ADD  1
            rom[2] <= 4'b1100; // CMP  0
            rom[3] <= 4'b1111; // JZ   3
        end
        else if (!halt) begin

            // ===== DEFAULT PC =====
            pc_next = pc + 1;

            // ===== EXECUTE =====
            case (opcode)

                // LOAD
                2'b00: begin
                    acc <= ram[operand];
                end

                // ADD
                2'b01: begin
                    acc <= acc + ram[operand];
                end

                // STORE / HALT
                2'b10: begin
                    if (operand == 2'b11 && acc == 2'b11)
                        halt <= 1;      // HALT
                    else
                        ram[operand] <= acc;
                end

                // CONTROL
                2'b11: begin
                    case (operand)

                        2'b00: begin // OUT
                            out <= acc;
                        end

                        2'b01: begin // CMP RAM[1]
                            Z <= (acc == ram[1]);
                        end

                        2'b10: begin // JMP 2
                            pc_next <= 2;
                        end

                        2'b11: begin // JZ 3
                            if (Z)
                                pc_next <= 3;
                        end

                    endcase
                end

            endcase

            // ===== UPDATE PC =====
            pc <= pc_next;
        end
    end

endmodule
