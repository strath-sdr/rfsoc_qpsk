
//-----------------------------------------------------------------
//
//  Filename      : synth_reg.v
//
//  Date          : 4/19/2005
//
//  Description   : Verilog description of SRL16E based delay and
//                  retiming register module.
//                  This code is synthesizable.
//
//
//  Mod. History  : Translated VHDL code to Verilog
//                : Fixed synth_reg_reg
//
//  Mod. Dates    : 6/29/2004
//                : 12/14/2004
//
//-------------------------------------------------------------------

/*`timescale 1 ns / 10 ps
module srl17e (clk, ce, d, q);
    parameter width = 16;
    parameter latency = 8;
    input clk, ce;
    input [width-1:0] d;
    output [width-1:0] q;
    parameter signed [5:0] a = latency - 2;
    wire[width - 1:0] #0.2 d_delayed;
    wire[width - 1:0] srl16_out;
    genvar i;
    assign d_delayed = d ;
    generate
      for(i=0; i<width; i=i+1)
      begin:reg_array
            if (latency > 1)
                begin: has_2_latency
                 SRL16E u1 (.CLK(clk), .D(d_delayed[i]), .Q(srl16_out[i]), .CE(ce), .A0(a[0]), .A1(a[1]), .A2(a[2]), .A3(a[3]));
                end
            if (latency <= 1)
                begin: has_1_latency
                 assign srl16_out[i] = d_delayed[i];
                end
            if (latency != 0)
                begin: has_latency
                 FDE u2 (.C(clk), .D(srl16_out[i]), .Q(q[i]), .CE(ce));
                end
            if (latency == 0)
                begin:has_0_latency
                 assign q[i] = srl16_out[i];
                end
        end
    endgenerate
endmodule */

/////////////////////srlc33e implementation////////////////


`timescale 1 ns / 10 ps
module srlc33e (clk, ce, d, q);
    parameter width = 16;
    parameter latency = 8;
    input clk, ce;
    input [width-1:0] d;
    output [width-1:0] q;
    parameter signed [5:0] a = latency - 2;
    wire[width - 1:0] #0.2 d_delayed;
    wire[width - 1:0] srlc32_out;
    genvar i;
    assign d_delayed = d ;
    generate
      for(i=0; i<width; i=i+1)
      begin:reg_array
            if (latency > 1)
                begin: has_2_latency
                 SRLC32E u1 (.CLK(clk), .D(d_delayed[i]), .Q(srlc32_out[i]), .CE(ce), .A(a));
                end
            if (latency <= 1)
                begin: has_1_latency
                 assign srlc32_out[i] = d_delayed[i];
                end
            if (latency != 0)
                begin: has_latency
                 FDE u2 (.C(clk), .D(srlc32_out[i]), .Q(q[i]), .CE(ce));
                end
            if (latency == 0)
                begin:has_0_latency
                 assign q[i] = srlc32_out[i];
                end
        end
    endgenerate
endmodule

module synth_reg (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter latency  = 1;
   input[width - 1:0] i;
   input ce,clr,clk;
   output[width - 1:0] o;
   parameter complete_num_srlc33es = latency/33;
   parameter remaining_latency = latency%33;
   parameter temp_num_srlc33es = (latency/33) + ((latency%33)?1:0);
   parameter num_srlc33es = temp_num_srlc33es ? temp_num_srlc33es : 1;
   wire [width - 1:0] z [0:num_srlc33es-1];
   genvar t;
    generate
      if (latency <= 33)
          begin:has_only_1
              srlc33e #(width, latency) srlc33e_array0(.clk(clk), .ce(ce), .d(i), .q(o));
          end
     endgenerate
    generate
     if (latency > 33)
        begin:has_1
             assign o = z[num_srlc33es-1];
             srlc33e #(width, 33) srlc33e_array0(.clk(clk), .ce(ce), .d(i), .q(z[0]));
        end
   endgenerate
   generate
      if (latency > 33)
          begin:more_than_1
              for (t=1; t < complete_num_srlc33es; t=t+1)
                begin:left_complete_ones
                   srlc33e #(width, 33) srlc33e_array(.clk(clk), .ce(ce), .d(z[t-1]), .q(z[t]));
                end
          end
   endgenerate
   generate
     if ((remaining_latency > 0) && (latency>33))
          begin:remaining_ones
             srlc33e #(width, (latency%33)) last_srlc33e (.clk(clk), .ce(ce), .d(z[num_srlc33es-2]), .q(z[num_srlc33es-1]));
          end
   endgenerate
endmodule
module synth_reg_reg (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter latency  = 1;
   input[width - 1:0] i;
   input ce, clr, clk;
   output[width - 1:0] o;
   wire[width - 1:0] o;
   genvar idx;
   reg[width - 1:0] reg_bank [latency:0];
   integer j;

   initial
     begin
	for (j=0; j < latency+1; j=j+1)
	  begin
	     reg_bank[j] = {width{1'b0}};
	  end
     end
   
   generate
     if (latency == 0)
        begin:has_0_latency
         assign o = i;
       end
   endgenerate
   
   always @(i)
	begin
	     reg_bank[0] = i;
	 end

   generate
     if (latency > 0)
        begin:more_than_1
	    assign o = reg_bank[latency];
         for (idx=0; idx < latency; idx=idx+1) begin:sync_loop
            always @(posedge clk)
                begin
                 if(clr)
                    begin
                      //for (j=0; j < latency+1; j=j+1)
                      //  begin
                          reg_bank[idx+1] = {width{1'b0}};
                      // end
                    end
                 else if (ce)
                    begin
                        reg_bank[idx+1] <= reg_bank[idx] ;
                    end
               end
        end
      end
   endgenerate
endmodule


