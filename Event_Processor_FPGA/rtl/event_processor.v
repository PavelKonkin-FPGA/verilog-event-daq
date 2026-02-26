module event_processor (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        strobe,
    input  wire [31:0] current_time,
    
    output reg [31:0]  fifo_data,
    output reg         fifo_wr_req
);

    parameter IDLE_LIMIT = 24'd2000;
	 
    reg [23:0] idle_counter;
    reg [15:0] pulse_count;
    reg [31:0] start_time;
    reg [31:0] last_event_time;
    reg        is_active;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            idle_counter <= 0;
            pulse_count  <= 0;
            is_active    <= 0;
            fifo_wr_req  <= 0;
        end else begin
            fifo_wr_req <= 0;

            if (strobe) begin
                idle_counter    <= 0;
                pulse_count     <= pulse_count + 1'b1;
                last_event_time <= current_time;
                
                if (!is_active) begin
                    is_active  <= 1;
                    start_time <= current_time;
                end
            end else if (is_active) begin
                if (idle_counter < IDLE_LIMIT) begin
                    idle_counter <= idle_counter + 1'b1;
                end else begin
                  
                    is_active   <= 0;

                    fifo_data   <= last_event_time - start_time; 
                    fifo_wr_req <= 1; 
                    pulse_count <= 0;
                end
            end
        end
    end
endmodule