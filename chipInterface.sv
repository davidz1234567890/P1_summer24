module BCDtoSevenSegment
(input logic [3:0] bcd,
output logic [6:0] segment);
  always_comb
    unique case (bcd)
      4'b0000: segment = 7'b011_1111;
      4'b0001: segment = 7'b000_0110;
      4'b0010: segment = 7'b101_1011;
      4'd3: segment = 7'b100_1111;
      4'd4: segment = 7'b110_0110;
      4'd5: segment = 7'b110_1101;
      4'd6: segment = 7'b111_1101;
      4'd7: segment = 7'b000_0111;
      4'd8: segment = 7'b111_1111;
      4'd9: segment = 7'b110_0111;
      default: segment = 7'bxxx_xxxx;
    endcase
endmodule: BCDtoSevenSegment

module fourbittoSevenSegment
(input logic [3:0] bcd,
output logic [6:0] segment);
  always_comb
    unique case (bcd)
      4'b0000: segment = 7'b011_1111;
      4'b0001: segment = 7'b000_0110;
      4'b0010: segment = 7'b101_1011;
      4'd3: segment = 7'b100_1111;
      4'd4: segment = 7'b110_0110;
      4'd5: segment = 7'b110_1101;
      4'd6: segment = 7'b111_1101;
      4'd7: segment = 7'b000_0111;
      4'd8: segment = 7'b111_1111;
      4'd9: segment = 7'b110_0111;

      //new ones here 
      4'd10: segment = 7'b111_0111;
      4'd11: segment = 7'b111_1100;
      4'd12: segment = 7'b011_1001;
      4'd13: segment = 7'b101_1110;
      4'd14: segment = 7'b111_1001;
      4'd15: segment = 7'b111_0001;
      default: segment = 7'bxxx_xxxx;
    endcase
endmodule: fourbittoSevenSegment



module chipInterface(input logic Button0, Button2,
                     output logic LEDR0,
                     output logic [6:0] HEX3, HEX2, HEX1, HEX0);

logic clock, reset_l, go_l;
logic [7:0] inA, Q;

p1 DUT (/*input logic*/.clock(clock), .reset_l(reset_l), .go_l(go_l),
        /*input logic [7:0]*/ .inA(inA),
          /*output logic [7:0]*/ .Q(Q));

logic [7:0] intermediate_tbSum;
logic L0;

tatb DUT2 (.ck(clock), .done(DUT.done), .reset_l(reset_l), Button0, //not sure
   //the following 4 are outputs
   .valueToinA(inA), // connect this to sumitup's inA
   .tbSum(intermediate_tbSum),      // tb's sum for display
   .go_l(go_l), 
   .L0(L0),   
         // L0 indicating sums match //not sure about this
   .outResult(Q));

assign LEDR0 = L0;
logic [3:0] tbsumtop, tbsumbottom, Qtop, Qbottom;
assign tbsumtop = intermediate_tbSum[7:4];
assign tbsumbottom = intermediate_tbSum[3:0];

fourbittoSevenSegment DUT3(/*input logic [3:0]*/ .bcd(tbsumtop),
/*output logic [6:0]*/ .segment(HEX3));

fourbittoSevenSegment DUT4(/*input logic [3:0]*/ .bcd(tbsumbottom),
/*output logic [6:0]*/ .segment(HEX2));

assign Qtop = Q[7:4];
assign Qbottom = Q[3:0];

fourbittoSevenSegment DUT5(/*input logic [3:0]*/ .bcd(Qtop),
/*output logic [6:0]*/ .segment(HEX1));

fourbittoSevenSegment DUT6(/*input logic [3:0]*/ .bcd(Qbottom),
/*output logic [6:0]*/ .segment(HEX0));

endmodule: chipInterface 