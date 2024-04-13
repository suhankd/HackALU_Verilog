module ALU (
    input [15:0] x,     
    input [15:0] y,     
    input zx,           
    input nx,          
    input zy,           
    input ny,           
    input f,            
    input no,

    output [15:0] out,
    output zr,          
    output ng           
);

//Declares a set of 11 16 bit registers.

reg[15:0] zdx, nzdx, zdy, nzdy, mnzx, mnzy, xplusy, xandy, fxy, nefxy; 


//START

//Figuring out if x and y have to be zeroed, or then negated.

always @ (x or zx)
begin
    if(zx)
        zdx = 16'b0;
    else
        zdx = x;
end

always @ (zdx or nx)
begin
    if(nx)
        nzdx = ~zdx;
    else
        nzdx = zdx;
end

always @ (y or zy)
begin
    if(zy)
        zdy = 16'b0;
    else
        zdy = y;
end

always @ (zy or ny)
begin
    if(ny)
        nzdy = ~zdy;
    else
        nzdy = zdy;
end

//ANDing and ADDing the values, and then selecting the desired one.

always @ (nzdx or nzdy)
begin
    xandy = nzdx & nzdy;
end

always @ (nzdx or nzdy)
begin
    xplusy = nzdx+nzdy;
end

always @ (xplusy or xandy)
begin
    if(f)
        fxy = xplusy;
    else
        fxy = xandy;
end

//Negating the output if told to, using the 2's complement system.

always @ (fxy)
begin
    if(no)
        nefxy = ~fxy + 1;
    else
        nefxy = fxy;
end

//Calculating the outputs.

always @ (nefxy)
begin
    if(nefxy == 16'b0)
        zr = 1'b1;
    else
        zr = 1'b0;
end

always @ (nefxy)
begin
    if(nefxy[15] == 1)
        ng = 1'b1;
    else
        ng = 1'b0;
end

assign out = nefxy;

endmodule










