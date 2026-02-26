module signal_frontend (
    input  wire clk,
    input  wire rst_n,
    input  wire async_in,
    output wire strobe
);
    reg [2:0] sync_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) sync_reg <= 3'b0;
        else sync_reg <= {sync_reg[1:0], async_in};
    end

    assign strobe = (sync_reg[1] && !sync_reg[2]); 
endmodule