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