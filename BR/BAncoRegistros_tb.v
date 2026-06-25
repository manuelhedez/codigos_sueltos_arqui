
module BancoRegistros_tb;
    reg [4:0] AR1;
    reg [4:0] AR2;
    reg [4:0] AW;
    reg [31:0] DW;
    reg EW;
    wire [31:0] Dr1;
    wire [31:0] Dr2;

    BancoRegistros uut (
        .AR1(AR1), 
        .AR2(AR2), 
        .AW(AW), 
        .DW(DW), 
        .EW(EW), 
        .Dr1(Dr1), 
        .Dr2(Dr2)
    );

    initial 
	 begin
AR1=5'd0;
AR2=5'd16;
#100
AR1=5'd1;
AR2=5'd17;
#100
AR1=5'd2;
AR2=5'd18;
#100
AR1=5'd3;
AR2=5'd19;
#100
AR1=5'd4;
AR2=5'd20;
#100
AR1=5'd5;
AR2=5'd21;
#100
AR1=5'd6;
AR2=5'd22;
#100
AR1=5'd7;
AR2=5'd23;
#100
AR1=5'd8;
AR2=5'd24;
#100
AR1=5'd9;
AR2=5'd25;
#100
AR1=5'd10;
AR2=5'd26;
#100
AR1=5'd11;
AR2=5'd27;
#100
AR1=5'd12;
AR2=5'd28;
#100
AR1=5'd13;
AR2=5'd29;
#100
AR1=5'd14;
AR2=5'd30;
#100
AR1=5'd15;
AR2=5'd31;
#100
		$stop;
			
    end
      
endmodule