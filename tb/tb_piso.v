//******************************************************************************
// file:    tb_piso.v
//
// author:  JAY CONVERTINO
//
// date:    2025/04/15
//
// about:   Brief
// Test bench for parallel to serial core.
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

`timescale 1 ns/10 ps

/*
 * Module: tb_piso
 *
 * Test bench for piso. Pump in data to parallel port on each count == 0.
 *
 */
module tb_piso ();
  
  reg tb_clk = 0;
  reg tb_rstn = 0;

  reg tb_ena;
  reg tb_load;
  reg [7:0] tb_pdata;

  reg [7:0] tb_data;
  reg [7:0] fin_data;

  wire tb_sdata;
  wire [7:0] tb_dcount;

  
  //1ns
  localparam CLK_PERIOD = 20;

  localparam RST_PERIOD = 500;

  //Group: Instantiated Modules

  /*
   * Module: piso
   *
   * Device under test, parallel to serial
   */
  piso #(
    .BUS_WIDTH(1)
  ) dut (
    .clk(tb_clk),
    .rstn(tb_rstn),
    .ena(tb_ena),
    .load(tb_load),
    .pdata(tb_pdata),
    .sdata(tb_sdata),
    .dcount(tb_dcount)
  );
  
  //axis clock
  always
  begin
    tb_clk <= ~tb_clk;
    
    #(CLK_PERIOD/2);
  end
  
  //reset
  initial
  begin
    tb_rstn <= 1'b0;
    
    #RST_PERIOD;
    
    tb_rstn <= 1'b1;
  end
  
  //copy pasta, fst generation
  initial
  begin
    $dumpfile("tb_piso.fst");
    $dumpvars(0,tb_piso);
  end

  always @(posedge tb_clk)
  begin
    if(tb_rstn == 1'b0)
    begin
      tb_pdata <= 0;
      tb_ena <= 1'b0;
      tb_load <= 1'b0;
      fin_data <= 0;
    end else begin
      tb_ena <= ~tb_ena & ~tb_load;
      tb_load <= 1'b0;
      tb_pdata <= tb_pdata;

      if(tb_dcount == 0 && tb_load == 1'b0)
      begin
        tb_ena <= tb_ena;
        tb_load <= 1'b1;
        tb_pdata <= tb_pdata + 1;fin_data
        fin_data <= tb_data;
      end

      if(tb_pdata == 255)
      begin
       $finish();
      end
    end
  end

  always @(negedge tb_clk)
  begin
    if(tb_rstn == 1'b0)
    begin
      tb_data <= 0;
    end else begin
      if(tb_ena == 1'b1)
      begin
        tb_data <= {(tb_dcount == 8 ? 6'b000000 : tb_data[6:0]), tb_sdata};
      end
    end
  end
endmodule
