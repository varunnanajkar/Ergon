`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
//////////////////////////////////////////////////////////////////////////////////


module FIFO_tb;

 parameter width = 8;
 parameter depth = 8;
 reg rd_en;
 reg [width -1 :0]wr;
 reg wr_en;
 reg clk;
 reg rst_n;
 
 wire full;
 wire empty;
 wire [width -1:0]rd;
 
 
 FIFO #(
      .width(width),
      .depth(depth)
      )
    dut
      (
 
     .rd_en(rd_en),
     .wr_en(wr_en),
     .clk(clk),
     .rst_n(rst_n),
     .rd(rd),
     .wr(wr),
     .full(full),
     .empty(empty)
     );
     
   
   
   initial begin
     clk = 0;
     forever #5 clk = ~clk;  
    end
     
     
     initial begin
      
      wr_en = 0;
      rd_en = 0;
      rst_n = 0;
      wr    = 0;
     
     
     
      
      #20;
      rst_n=1;
      
  //writing 8 elements    
      repeat(40)
      begin
         @(posedge clk);
          wr_en=1;
          wr =wr +1;
       
       end
       
       @(posedge clk);
         wr_en=0;
       
 // reading   4 elements   
       repeat(60)
       begin
         @(posedge clk);
           rd_en=1;
       end
       
        @(posedge clk);
          rd_en =0;
      #0;
      $finish;
     end
     
     
    initial begin
      $monitor( "Time=%0t rst_n=%b wr_en=%b rd_en=%b wr=%d rd=%d full=%b empty=%b",
      $time,rst_n,wr_en,rd_en,wr,rd,full,empty);
    end

     

    
          
endmodule
