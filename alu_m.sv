module alu_m #(parameter WIDTH = 1) (accum,data,opcode,out,zero,clk);
 
  input  logic [WIDTH-1:0] accum;
  input  logic [WIDTH-1:0] data;
  output logic [WIDTH-1:0] out;
  input logic        [2:0] opcode;
  input logic              clk;
  output logic             zero;
 
  timeunit 1ns;
  timeprecision 100ps;
 
  typedef enum logic [2:0] {
    HLT = 3'b0,
    SKZ = 3'b001,
    ADD = 3'b010,
    AND = 3'b011,
    XOR = 3'b100,
    LDA = 3'b101,
    STO = 3'b110,
    JMP = 3'b111} opcode_e;
 
  typedef opcode_e [0:0] opcode_e_array_t;
 
  typedef struct packed {
    opcode_e_array_t op;
  } op_struct_t;
 
  opcode_e_array_t op_a;

 
  always_comb begin
  op_a =  opcode;
  end
 
  always_comb begin
    if(!accum)
      zero <= 1'b1;
    else
      zero <= 1'b0;
  end
 
  always_comb begin
    unique case(op_a)
      HLT:begin
        out <= accum;
      end
      SKZ:begin
        out <= accum;
      end
      ADD:begin
        out <= data + accum;
      end
       AND:begin
        out <= data & accum;
      end
       XOR:begin
        out <= data ^ accum;
      end
       LDA:begin
         out <= data;
      end
       STO:begin
        out <= accum;
      end
       JMP:begin
        out <= accum;
      end
      default:begin
        out <= out;
      end
    endcase
  end    
endmodule