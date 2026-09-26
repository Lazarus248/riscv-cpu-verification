`timescale 1ns/1ps
module tb_top;

    logic clock;
    logic reset;

    logic [31:0] inst;
    logic [31:0] pc;

    logic [31:0] bus_address;
    logic [31:0] bus_read_data;
    logic [31:0] bus_write_data;
    logic [3:0]  bus_byte_enable;
    logic        bus_read_enable;
    logic        bus_write_enable;

    riscv_core dut (
        .clock            (clock),
        .reset            (reset),
        .bus_address      (bus_address),
        .bus_read_data    (bus_read_data),
        .bus_write_data   (bus_write_data),
        .bus_byte_enable  (bus_byte_enable),
        .bus_read_enable  (bus_read_enable),
        .bus_write_enable (bus_write_enable),
        .inst             (inst),
        .pc               (pc)
    );

    initial begin
        clock = 0;
    end

    always #5 clock = ~clock;

    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    always_comb begin
    case (pc)
        32'h00400000: inst = 32'h00500093;
        32'h00400004: inst = 32'h00700113;
        32'h00400008: inst = 32'h002081B3;
        default:       inst = 32'h00000013;
    endcase
end

    assign bus_read_data = 32'b0;

always @(negedge clock) begin
    if (!reset) begin
        $display(
            "time=%0t pc=%08h inst=%08h x1=%0d x2=%0d x3=%0d",
            $time,
            pc,
            inst,
            dut.singlecycle_datapath.regfile.register[1],
            dut.singlecycle_datapath.regfile.register[2],
            dut.singlecycle_datapath.regfile.register[3]
        );
    end
end

  initial begin
    #55;

    if (dut.singlecycle_datapath.regfile.register[3] == 32'd12)
        $display("[PASS] ADD test passed: x3 = %0d",
                 dut.singlecycle_datapath.regfile.register[3]);
    else
        $display("[FAIL] ADD test failed: expected 12, got %0d",
                 dut.singlecycle_datapath.regfile.register[3]);

    $finish;
end

endmodule