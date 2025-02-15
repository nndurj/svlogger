`timescale 1 ns / 1 ps
`default_nettype none

`include "svlogger.sv"

module fsm_example

    #(
    parameter NAME = 0
    )(
    input logic aclk,
    input logic aresetn
    );

    typedef enum logic[3:0] {
        IDLE = 0,
        ONE = 1,
        TWO = 2,
        THREE = 3,
        FOUR = 4,
        FIVE = 5,
        SIX = 6
    } ex_fsm;

    ex_fsm fsm;

    svlogger mylog;

    initial begin
        mylog = new("MyFSM", `SVL_VERBOSE_DEBUG, `SVL_ROUTE_TERM);
    end

    always @ (posedge aclk or negedge aresetn) begin

        if (aresetn == 1'b0) begin
            fsm <= IDLE;
        end else begin

            case (fsm)
                default: begin
                    mylog.debug("Start in IDLE state");
                    fsm <= ONE;
                end
                ONE: begin
                    mylog.info("Moving in ONE state");
                    fsm <= TWO;
                end
                TWO: begin
                    mylog.warning("Moving in TWO state");
                    fsm <= THREE;
                end
                THREE: begin
                    mylog.critical("Moving in THREE state");
                    fsm <= FOUR;
                end
                FOUR: begin
                    mylog.error("Moving in FOUR state");
                    fsm <= IDLE;
                end
            endcase
        end
    end
endmodule

`resetall

