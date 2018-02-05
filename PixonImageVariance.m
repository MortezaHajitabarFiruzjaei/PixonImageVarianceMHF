%=================================================================
%Morteza Hajitabar Firuzjaei
%Senior Computer Programmer
%=================================================================
clc;
clear all;
close all
I =imread('a.jpg');
if length(size(I))==3
  I=rgb2gray(I);
end
I=imresize(I,[256,256]);
I=double(I); [rows,cols] = size(I); Lp=I;
mat(:,:)=0;  x=0; THR=70;  Lp(:,:)=0;%Lp: matrix edge   
%=================================================================
for i=1:rows
    for j=1:cols
        if Lp(i,j)==0
            k=1;x=x+1;Lp(i,j)=x;
            %Pixon is a matrix with size of [2,number of pixons]
            Pixon(1,x)=I(i,j);%The summation of pixels in a Pixon
            Pixon(2,x)=1;%Number of pixels in a Pixon
            Pixon=double(Pixon);a=i; b=j;
            while k~=0
                east=1; eastsouth=0; south=0; westsouth=0;          
                west=0; westnorth=0; north=0; eastnorth=0;
                while (east || eastsouth || south || westsouth || west || westnorth || north || eastnorth)
                    east=0; eastsouth=0; south=0; westsouth=0;      
                    west=0; westnorth=0; north=0; eastnorth=0;s1=0; n1=0;
                    if b~=cols && Lp(a,b+1)==0
                        %=======================================================
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a,b+1)) < THR
                            disp(abs(((I(a,b)-(Pixon(1,x)/Pixon(2,x)))/Pixon(2,x))-I(a,b+1)));
                            %=======================================================
                            %if difference between the “neighbour pixel and the variance of pixels in
                            %pixon is less than a thershold, this pixel will be connected to this Pixon. 
                            Lp(a,b+1)=x;s1=s1+I(a,b+1);n1=n1+1;east=1;
                            %Lp is a matrix with size of image that holds the pixon labels of pixels
                        end;
                    end
                    if b~=cols && a~=rows && Lp(a+1,b+1)==0
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a+1,b+1)) < THR
                            Lp(a+1,b+1)=x;s1=s1+I(a+1,b+1);n1=n1+1;eastsouth=1;
                        end;
                    end                       
                    if a~=rows && Lp(a+1,b)==0
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a+1,b)) < THR
                            Lp(a+1,b)=x;s1=s1+I(a+1,b);n1=n1+1;south=1;
                        end;
                    end
                    if a~=rows && b~=1 && Lp(a+1,b-1)==0
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a+1,b-1)) < THR
                            Lp(a+1,b-1)=x;s1=s1+I(a+1,b-1);n1=n1+1;westsouth=1;
                        end;
                    end
                    if b~=1 && Lp(a,b-1)==0
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a,b-1)) < THR
                            Lp(a,b-1)=x;s1=s1+I(a,b-1);n1=n1+1;west=1;
                        end;
                    end
                    if b~=1 && a~=1 && Lp(a-1,b-1)==0
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a-1,b-1)) < THR
                            Lp(a-1,b-1)=x;s1=s1+I(a-1,b-1);n1=n1+1;westnorth=1;
                        end;
                    end
                    if a~=1 && Lp(a-1,b)==0
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a-1,b)) < THR
                            Lp(a-1,b)=x;s1=s1+I(a-1,b);n1=n1+1;north=1;
                        end;
                    end
                    if b~=cols && a~=1 && Lp(a-1,b+1)==0
                        if abs((((I(a,b)-(Pixon(1,x)/Pixon(2,x)))^2)/Pixon(2,x))-I(a-1,b+1)) < THR
                            Lp(a-1,b+1)=x;s1=s1+I(a-1,b+1);n1=n1+1;eastnorth=1;
                        end;
                    end
                    Pixon(1,x)=Pixon(1,x)+s1;Pixon(2,x)=Pixon(2,x)+n1;
                    if east==1
                        b=b+1;
                        if eastnorth==1
                            mat(1,k)=a-1;mat(2,k)=b;k=k+1;
                        end
                        if north==1
                            mat(1,k)=a-1;mat(2,k)=b-1;k=k+1;
                        end
                        if westnorth==1
                            mat(1,k)=a-1;mat(2,k)=b-2;k=k+1;
                        end
                        if west==1
                            mat(1,k)=a;mat(2,k)=b-2;k=k+1;
                        end                            
                        if westsouth==1
                            mat(1,k)=a+1;mat(2,k)=b-2;k=k+1;
                        end
                        if south==1
                            mat(1,k)=a+1;mat(2,k)=b-1;k=k+1;
                        end
                        if eastsouth==1
                            mat(1,k)=a+1;mat(2,k)=b;k=k+1;
                        end                       
                        else if eastsouth==1
                            a=a+1; b=b+1;
                            if eastnorth==1
                                mat(1,k)=a-2;mat(2,k)=b;k=k+1;
                            end
                            if north==1
                                mat(1,k)=a-2;mat(2,k)=b-1;k=k+1;
                            end
                            if westnorth==1
                                mat(1,k)=a-2;mat(2,k)=b-2;k=k+1;
                            end
                            if west==1
                                mat(1,k)=a-1;mat(2,k)=b-2;k=k+1;
                            end
                            if westsouth==1
                                mat(1,k)=a;mat(2,k)=b-2;k=k+1;
                            end
                            if south==1
                                mat(1,k)=a;mat(2,k)=b-1;k=k+1;
                            end
                            else if south==1
                                a=a+1;
                                    if eastnorth==1
                                        mat(1,k)=a-2;mat(2,k)=b+1;k=k+1;
                                    end
                                    if north==1
                                    mat(1,k)=a-2;mat(2,k)=b;k=k+1;
                                    end
                                    if westnorth==1
                                        mat(1,k)=a-2;mat(2,k)=b-1;k=k+1;
                                    end
                                    if west==1
                                        mat(1,k)=a-1;mat(2,k)=b-1;k=k+1;
                                    end
                                    if westsouth==1
                                        mat(1,k)=a;mat(2,k)=b-1;k=k+1;
                                    end
                                    else if westsouth==1
                                        a=a+1;b=b-1;
                                        if eastnorth==1
                                            mat(1,k)=a-2;mat(2,k)=b+2;k=k+1;
                                        end
                                        if north==1
                                            mat(1,k)=a-2;mat(2,k)=b+1;k=k+1;
                                        end
                                        if westnorth==1
                                            mat(1,k)=a-2;mat(2,k)=b;k=k+1;
                                        end
                                        if west==1
                                            mat(1,k)=a-1;mat(2,k)=b;k=k+1;
                                        end
                                        else if west==1
                                            b=b-1;
                                            if eastnorth==1
                                            mat(1,k)=a-1;mat(2,k)=b+2;k=k+1;
                                            end
                                            if north==1
                                                mat(1,k)=a-1;mat(2,k)=b+1;k=k+1;
                                            end
                                            if westnorth==1
                                                mat(1,k)=a-1;mat(2,k)=b;k=k+1;
                                            end
                                            else if westnorth==1
                                                a=a-1; b=b-1;
                                                if eastnorth==1
                                                    mat(1,k)=a;mat(2,k)=b+2;k=k+1;
                                                end
                                                if north==1
                                                    mat(1,k)=a;mat(2,k)=b+1;k=k+1;
                                                end     
                                                else if north==1
                                                    a=a-1;
                                                    if eastnorth==1
                                                        mat(1,k)=a;mat(2,k)=b+1;k=k+1;
                                                    end
                                                    else if eastnorth==1
                                                        a=a-1;b=b+1;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                    end;
                end;
                k=k-1;
                if k~=0
                    a=mat(1,k);b=mat(2,k);
                end;
            end;
        end;
    end;
end;
%==================================================================
% make pixon
I_pix=I;I_pix(:,:)=0;
for i=1:rows
    for j=1:cols       
        I_pix(i,j)=ceil(Pixon(1,Lp(i,j))./Pixon(2,Lp(i,j)));
    end
end
figure(1),subplot(2,2,1),imshow(uint8(I));subplot(2,2,2),imshow(uint8(I_pix))
subplot(2,2,3),imhist(uint8(I));subplot(2,2,4),imhist(uint8(I_pix))


