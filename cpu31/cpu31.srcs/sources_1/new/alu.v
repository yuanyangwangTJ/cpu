// alu.v

module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
    );

    reg [31:0] result [0:15];  
    reg [32:0] temp;
    reg Z [0:15];
    reg C [0:15];
    reg N [0:15];
    reg O [0:15];
    wire signed [31:0] sa, sb;
    assign sa = a;
    assign sb = b;

    always@(a,b)
    begin
    //ADDU
    temp=0;
    temp=a+b;
    result[0]=temp[31:0];
    if(result[0]==0)
        Z[0]=1;
    else 
        Z[0]=0;
    C[0]=temp[32];
    N[0]=result[0][31];
    
    //ADD
    temp=0;
    temp=a+b;
    result[2]=temp[31:0];
    if(result[2]==0)
        Z[2]=1;
    else
        Z[2]=0;
    if(result[2][31]==1)
        N[2]=1;
    else
        N[2]=0;
    if(a[31]&b[31]&~result[2][31])
        O[2]=1;
    else if(~a[31]&~b[31]&result[2][31])
        O[2]=1;
    else
        O[2]=0;
    
    
    //SUBU
    temp=0;
    temp=a-b;
    result[1]=temp[31:0];
    if(result[1]==0)
        Z[1]=1;
    else
        Z[1]=0;
    C[1]=temp[32];
    N[1]=result[1][31];
    
    //SUB
    temp=0;
    temp=a-b;
    result[3]=temp[31:0];
    if(result[3]==0)
        Z[3]=1;
    else 
        Z[3]=0;
    N[3]=result[3][31];
    if(~a[31]&b[31]&result[3][31])
        O[3]=1;
    else if(a[31]&~b[31]&~result[3][31])
        O[3]=1;
    else
        O[3]=0;
    
    //AND
    temp=0;
    result[4]=a&b;
    if(result[4]==0)
        Z[4]=1;
    else
        Z[4]=0;
    N[4]=result[4][31];
    
    //OR
    temp=0;
    result[5]=a|b;
    if(result[5]==0)
        Z[5]=1;
    else
        Z[5]=0;
    N[5]=result[5][31];
    
    //XOR
    temp=0;
    result[6]=a^b;
    if(result[6]==0)
        Z[6]=1;
    else
        Z[6]=0; 
    N[6]=result[6][31];
    
    //NOR
    temp=0;
    result[7]=~(a|b);
    if(result[7]==0)
        Z[7]=1;
    else
        Z[7]=0;
    N[7]=result[7][31];
    
    //LUI
    temp=0;
    result[8]={b[15:0],16'b0};
    if(result[8]==0)
        Z[8]=1;
    else
        Z[8]=0;
    N[8]=result[8][31];
    
    //SLT
    temp=a-b;
    if(temp==0)
        Z[11]=1;
    else
        Z[11]=0;
    result[11]=sa < sb ? 1:0;
    N[11]=temp[31];
    
    //SLTU
    temp=a-b;
    result[10]=a < b ? 1:0;
    if(temp==0)
        Z[10]=1;
    else
        Z[10]=0;
    C[10]=result[10];
    N[10]=result[10][31];
    
    //SRA
    result[12]=($signed(b)>>>a);
    if(result[12]==0)
        Z[12]=1;
    else
        Z[12]=0;
    temp=$signed(b)>>>(a-1);
    C[12]=temp[0];
    N[12]=result[12][31];
    
    //SLL/SLA
    result[14]=b<<a;
    if(result[14]==0)
        Z[14]=1;
    else
        Z[14]=0;
    N[14]=result[14][31];
    temp=b<<a;
    C[14]=temp[32];
    
    //SRL
    result[13]=b>>a;
    if(result[13]==0)
        Z[13]=1;
    else
        Z[13]=0;
    N[13]=result[13][31];
    temp=b>>(a-1);
    C[13]=temp[0];
    end
    
    
    always@(*)
    begin
    case(aluc)
        4'b0000:
        begin
            r=result[0];
            zero=Z[0];
            carry=C[0];
            negative=N[0];
        end
        4'b0010:
        begin
             r=result[2];
             zero=Z[2];
             negative=N[2];
             overflow=O[2];
        end
        4'b0001:
        begin
             r=result[1];
             zero=Z[1];
             carry=C[1];
             negative=N[1];
        end
        4'b0011:
        begin
             r=result[3];
             zero=Z[3];
             negative=N[3];
             overflow=O[3];
        end
        4'b0100:
        begin
             r=result[4];
             zero=Z[4];
             negative=N[4];
        end
        4'b0101:
        begin
             r=result[5];
             zero=Z[5];
             negative=N[5];
        end
        4'b0110:
        begin
             r=result[6];
             zero=Z[6];
             negative=N[6];
        end
        4'b0111:
        begin
             r=result[7];
             zero=Z[7];
             negative=N[7];
        end
        4'b1000:
        begin
             r=result[8];
             zero=Z[8];
             negative=N[8];
        end        
        4'b1001:
        begin
             r=result[8];
             zero=Z[8];
             negative=N[8];
        end
        4'b1011:
        begin
             r=result[11];
             zero=Z[11];
             negative=N[11];
        end        
        4'b1010:
        begin
             r=result[10];
             zero=Z[10];
             carry=C[10];
             negative=N[10];
        end
        4'b1100:
        begin
             r=result[12];
             zero=Z[12];
             carry=C[12];
             negative=N[12];
        end
        4'b1110:
        begin
             r=result[14];
             zero=Z[14];
             carry=C[14];
             negative=N[14];
        end
        4'b1111:
        begin
             r=result[14];
             zero=Z[14];
             carry=C[14];
             negative=N[14];
        end
        4'b1101:
        begin
             r=result[13];
             zero=Z[13];
             carry=C[13];
             negative=N[13];
        end
    endcase   
    end
endmodule
