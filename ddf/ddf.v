module DFF(clock,D,Q,Qbar);
 input clock, D;
 output reg Q; // Q is a reg since it is assigned in an
always block
 output Qbar;
 assign Qbar = ~ Q; // Qbar is always just the inverse of Q
 always @(posedge clock) // perform actions whenever the clock rises
 Q = D;
endmodule