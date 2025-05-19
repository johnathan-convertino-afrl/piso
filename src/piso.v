//******************************************************************************
// file:    piso.v
//
// author:  JAY CONVERTINO
//
// date:    2025/04/15
//
// about:   Brief
// PISO (parallel in serial out) The idea is to keep this core simple,
// and let the control logic be handled outside of this core.
//
// license: License MIT
// Copyright 2025 Jay Convertino
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
//******************************************************************************

`resetall
`timescale 1 ns/10 ps
`default_nettype none

/*
 * Module: piso
 *
 * parllel in serial out
 *
 * Parametes:
 *  BUS_WIDTH - width of the parallel data input in bytes.
 *
 * Ports:
 *  clk     - global clock for the core.
 *  rstn    - negative syncronus reset to clk.
 *  ena     - enable for core, use to change output rate. Enable serial shift output.
 *  rev     - reverse, 0 is MSb first out, 1 is LSb first out.
 *  load    - load parallel data into core. Reset for next data message to send. This can be done at any time.
 *  pdata   - parallel data input, registered at load only.
 *  sdata   - serialized data output.
 *  dcount  - Number of bits to shift out. When the count hits zero, the parallel data register is empty and last bit is output on sdata.
 *
 */
module piso #(
      parameter BUS_WIDTH = 1
    ) (
      input   wire                    clk,
      input   wire                    rstn,
      input   wire                    ena,
      input   wire                    rev,
      input   wire                    load,
      input   wire  [BUS_WIDTH*8-1:0] pdata,
      output  wire                    sdata,
      output  wire  [BUS_WIDTH*8-1:0] dcount
    );

    `include "util_helper_math.vh"

    // makes life easier, calculate number of bits needed for count register
    localparam COUNT_WIDTH = clogb2(BUS_WIDTH*8)+1;

    // data count register
    reg [COUNT_WIDTH:0] r_dcount;

    // register to contain input parallel data that is positive edge shifted.
    reg [BUS_WIDTH*8-1:0] r_ppdata;

    // register for output data captured on postive edge
    reg r_sdata;

    // assign counter to output data count so cores can track output status.
    assign dcount = {{(BUS_WIDTH*8-COUNT_WIDTH-1){1'b0}}, r_dcount};

    // serialized output data.
    assign sdata = r_sdata;

    // Positive edge data count that is decremented on enable pulse.
    always @(posedge clk)
    begin
      if(rstn == 1'b0)
      begin
        r_dcount <= 0;
      end else begin
        r_dcount <= r_dcount;

        if(ena == 1'b1)
        begin
          r_dcount <= r_dcount - 1;

          if(r_dcount == 0)
          begin
            r_dcount <= r_dcount;
          end
        end

        if(load == 1'b1)
        begin
          r_dcount <= BUS_WIDTH*8;
        end
      end
    end

    // Positive edge shift register, parallel data is shifted (C) on enable.
    always @(posedge clk)
    begin
      if(rstn == 1'b0)
      begin
        r_ppdata <= 0;
        r_sdata <= 1'b0;
      end else begin
        r_ppdata <= r_ppdata;
        r_sdata  <= r_sdata;

        if(ena == 1'b1)
        begin
          //MSb first
          if(rev == 1'b0)
          begin
            r_ppdata <= {r_ppdata[BUS_WIDTH*8-2:0], 1'b0};
            r_sdata  <= r_ppdata[BUS_WIDTH*8-1];
          //LSb first
          end else begin
            r_ppdata <= {1'b0, r_ppdata[BUS_WIDTH*8-1:1]};
            r_sdata  <= r_ppdata[0];
          end
        end

        if(load == 1'b1)
        begin
          r_ppdata <= pdata;
        end
      end
    end
endmodule

`resetall
