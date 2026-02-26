module edge_detector (
    input  wire clk,
	 input  wire signal_in,
    output wire strobe      
);

    reg signal_prev;

    always @(posedge clk) begin
        signal_prev <= signal_in;
    end

    assign strobe = (signal_in != signal_prev);

endmodule