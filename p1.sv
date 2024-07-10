module Register
        #(parameter WIDTH=32)
        (input logic en, clear,
         input logic [WIDTH-1:0] D,
          input logic clock,
         output logic [WIDTH-1:0] Q);
         
        always_ff @(posedge clock)
          if (en)
            Q <= D;
          else if (clear)
            Q <= '0;
            
endmodule : Register


module p1(input logic clock, reset_l, go_l,
          input logic [7:0] inA,
          output logic [7:0] Q);
logic [7:0] sum;
logic done;// clock, reset_l, go_l;




 
 Register #(8) DUT(.en(done), .clear(1'b0), .D(sum), .clock(clock), .Q(Q));
 //only Q above is an output


 sumItUp DUT1 (.ck(clock), .reset_l(reset_l), .go_l(go_l),
   .inA(inA),
   .done(done),
   .sum(sum)); //done and sum are outputs
  
  /*tatb DUT2 (.ck(clock), .done(done), .reset_l(reset_l), Button0, //not sure
   .valueToinA(inA), // connect this to sumitup's inA
   .tbSum(intermediate_tbSum),      // tb's sum for display
   .go_l(go_l), 
   L0,         // L0 indicating sums match //not sure about this
   .outResult(Q));*/


endmodule: p1


module p1_test;
logic clock, reset_l, go_l;
logic [7:0] inA;
logic [7:0] Q;
p1 DUT2(.*);
initial begin
      clock = 0;
      reset_l = 0;
      #1 reset_l <= 1;
      forever #5 clock = ~clock;
end

initial begin

@(posedge clock);
go_l <= 1'b0;
inA <= 8'd4;
@(posedge clock);
go_l <= 1'b1;
inA <= 8'd4;
@(posedge clock);
inA <= 8'd4;
@(posedge clock);
inA <= 8'd0;
@(posedge clock);

@(posedge clock);
go_l <= 1'b0;
@(posedge clock);
go_l <= 1'b1;
inA <= 8'd3;
@(posedge clock);
inA <= 8'd3;
@(posedge clock);
inA <= 8'd3;
@(posedge clock);
inA <= 8'd0;
@(posedge clock);

@(posedge clock);

@(posedge clock);

@(posedge clock);
$finish;

end


endmodule: p1_test