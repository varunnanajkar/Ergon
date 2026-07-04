`timescale 1ns / 1ps     //time unit/time precision
//////////////////////////////////////////////////////////////////////////////////
// Description: 
// Synchronous fifo buffer using verilog standard 1364 2001
// Features:
// - Single clock FIFO
// - Separate read/write pointers
// - Count keeps track of occupied locations
// Author: Varun Nanajkar
// Date: 4 July 2026  
//////////////////////////////////////////////////////////////////////////////////


module FIFO #(
   //----------------------------------------------
   // Parameters
   //----------------------------------------------
   parameter width = 8,      //width of the FIFO
   parameter depth = 8       // # of FIFO entries
    )(

   //----------------------------------------------
   // Data Ports
   //----------------------------------------------                           
    input wire [width -1: 0] wr,     // Data to be written into FIFO
    output reg [width -1:0] rd,      // Data read from FIFO
   
   //----------------------------------------------
   // Control Signals
   //----------------------------------------------
    input rd_en,                     // Read enable
    input wr_en,                     // Write enable
    
   //----------------------------------------------
   // Status Flags
   //----------------------------------------------   
    output full,                     // FIFO is full
    output empty,                    // FIFO is empty
    
   //----------------------------------------------
   // Clock & Reset
   //----------------------------------------------                              
    input clk,                // declaration of clk and active low reset
    input rst_n
    
    );
    
    //Memory allocation onto fifo buffer
    reg [width -1 : 0] memory [0: depth -1];
    
    localparam d_depth = $clog2(depth);    //Applying ceiling log to get appropriate number of bits for the depth
    //Declaring the size of pointer
    reg [d_depth-1 : 0] rd_ptr;
    reg [d_depth -1 : 0] wr_ptr;
 
    reg [d_depth : 0 ] count;
    
    //continuous assignment for the flags full and empty to check condition
    assign full = (count == depth)   ;
    assign empty = (count == 0)      ;
    
    always @(posedge clk or negedge rst_n)           //always condition to initiate loop for read and write fuction
    begin

       if (!rst_n) begin                             //condition to check for reset being low
        
       count <=  0;                                  //reseting pointer positions of 
       rd_ptr <= 0;                                  // read/write and count pointer
       wr_ptr <= 0;
    
       end
       
       else begin
       
          if (wr_en && !full) begin                 //Checking condition for write operation
                                                    //write enable and !full are the two conditions to be able to write
             memory[wr_ptr] <= wr;                  //writing data onto memory using the write pointer
             wr_ptr <=wr_ptr +1;                    //incrementing the write pointer
          end                                       // automatic wrap around takes place as there is no consideration for carries
          
              
          if (rd_en && !empty) begin               //Checking condition for read operation
                                                   //read enable and !empty are the two condtions to be able to read
             rd <= memory[rd_ptr];                 //reading from memory using using read pointer
             rd_ptr <= rd_ptr + 1;                 //incrementing the read pointer
          end                                      // automatic wrap around takes place as there is no consideration for carries
         
                                                    
         case ({wr_en && !full, rd_en && !empty})    //case statments to take care of extreme cases such as  simultaneous read/write operations
          
             2'b10:                                  //this takes care of the first case condition(ie.  write operation)
             
                count <= count + 1;                  //counter is incremented to take care of full flag condition
               
             
             
             2'b01:                                  //this takes care of the second case condition(ie. read operation)
         
                count <= count - 1;                  //counter is decremented to take care of empty flag condition
          
        
            default:                                 //this takes care of the peripherel cases such simultaneous read and write or neither
                
                count <= count;                      //count doesn't change for cases where both read and write are implemented or neither happen
                
                
              
         endcase
     end
  end
    
endmodule
