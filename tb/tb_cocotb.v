//******************************************************************************
// file:    tb_cocotb.v
//
// author:  JAY CONVERTINO
//
// date:    2025/04/15
//
// about:   Brief
// Test bench wrapper for cocotb
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
// IN THE SOFTWARE.BUS_WIDTH
//
//******************************************************************************

`timescale 1ns/100ps

/*
 * Module: tb_cocotb
 *
 * PISO Wrapper
 *
 * Parameters:
 *
 *   BUS_WIDTH       - Width of the parallel input in bytes
 *
 * Ports:
 *
 *   clk     - Clock
 *   rstn    - negative reset
 *   ena     - enable for core, use to change output rate. Enable serial shift output.
 *   rev     - reverse, 0 is MSb first out, 1 is LSb first out.
 *   load    - load parallel data into core. This can be done at any time.
 *   pdata   - parallel data input, registered at load only.
 *   sdata   - serialized data output.
 *   dcount  - Number of bits to shift out (what is left, first bit is always available).
 */
module tb_cocotb #(
    parameter BUS_WIDTH     = 4
  )
  (
    input                     clk,
    input                     rstn,
    input                     ena,
    input                     rev,
    input                     load,
    input   [BUS_WIDTH*8-1:0] pdata,
    output                    sdata,
    output  [BUS_WIDTH*8-1:0] dcount
  );
  // fst dump command
  initial begin
    $dumpfile ("tb_cocotb.fst");
    $dumpvars (0, tb_cocotb);
    #1;
  end
  
  //Group: Instantiated Modules

  /*
   * Module: dut
   *
   * Device under test, piso
   */
  piso #(
    .BUS_WIDTH(BUS_WIDTH)
  ) dut (
    .clk(clk),
    .rstn(rstn),
    .ena(ena),
    .rev(rev),
    .load(load),
    .pdata(pdata),
    .sdata(sdata),
    .dcount(dcount)
  );
  
endmodule

