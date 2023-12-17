`timescale 1ns/1ps

module stack(
    input [DATA_WIDTH-1:0] DATA_IN,
    input CLK,
    input nRW,
    input CE,
    input nRST,
    output reg [DATA_WIDTH-1:0] DATA_OUT,
    output reg FULL,
    output reg EMPTY
);

parameter DATA_WIDTH = 8;
parameter DEPTH = 3;

reg [DATA_WIDTH-1:0] STACK [0:(2**DEPTH)-1];
reg [DEPTH-1:0] SP;
reg [DATA_WIDTH-1:0] INDEX, NEXT_INDEX;
reg [DATA_WIDTH-1:0] NEXT_DATA_OUT;

always @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        DATA_OUT <= 8'b00000000;
        SP <= 3'b000;
        EMPTY <= 1'b1;
        FULL <= 1'b0;
    end else if(nRW == 1'b0 && CE == 1'b1) begin // read condition
        if (EMPTY) begin
            SP <= SP;
            EMPTY <= EMPTY;
        end else if (SP == 3'b001) begin // && EMPTY == 1'b0
            SP <= SP - 1;
            // DATA_OUT <= STACK[SP];
            EMPTY <= 1'b1;
        end else if (SP == 3'b111 && FULL == 1'b1) begin
            SP <= SP;
            // DATA_OUT <= STACK[SP];
            EMPTY <= 1'b0;
            FULL <= 1'b0;
        end else begin
            SP <= SP - 1;
            // DATA_OUT <= STACK[SP-1];
            EMPTY <= 1'b0;
            FULL <= 1'b0;
        end
    end else if(nRW == 1'b1 && CE == 1'b1) begin // write condition
        if (FULL) begin
            SP <= SP;
            FULL <= FULL;
        end else if (SP == 3'b111 && FULL == 1'b0) begin
            SP <= SP;
            STACK[SP] <= DATA_IN;
            FULL <= 1'b1;
        end else begin
            SP <= SP + 1;
            STACK[SP] <= DATA_IN;
            FULL <= 1'b0;
            EMPTY <= 1'b0;
        end
    end
end

always @(*) begin
    if (SP == 3'b000 && EMPTY == 1'b0) DATA_OUT <= STACK[SP];
    else if (SP == 3'b111 && FULL == 1'b1) DATA_OUT <= STACK[SP];
    else DATA_OUT <= STACK[SP-1];
end

endmodule // stack