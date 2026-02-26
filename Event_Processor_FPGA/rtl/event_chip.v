module event_chip (
    input  wire clk,
    input  wire rst_n,
    input  wire sensor,
    output wire [31:0] led_debug
);

    wire [31:0] global_time;
    wire        clean_strobe;
    wire [31:0] out_data;
    wire        write_to_fifo;

    timer my_timer (
        .clock  (clk),
        .clk_en (1'b1),
        .sclr   (!rst_n),
        .q      (global_time)
    );

    signal_frontend my_frontend (
        .clk      (clk),
        .rst_n    (rst_n),
        .async_in (sensor),
        .strobe   (clean_strobe)
    );

    event_processor my_brain (
        .clk          (clk),
        .rst_n        (rst_n),
        .strobe       (clean_strobe),
        .current_time (global_time),
        .fifo_data    (out_data),
        .fifo_wr_req  (write_to_fifo)
    );

    data_fifo my_buffer (
        .clock (clk),
        .data  (out_data),
        .rdreq (1'b0),
        .wrreq (write_to_fifo),
		  .q (led_debug),
        .full  ()
    );

endmodule