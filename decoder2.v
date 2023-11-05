module decoder2(
    input SEL,
    input EN,
    output reg [1:0] OUT
);

always @(*) begin
    if(EN) begin
        case(SEL)
            1'b0: OUT <= 2'b01;
            1'b1: OUT <= 2'b10;
        endcase
    end else OUT <= 2'b00;
end

endmodule // decoder2