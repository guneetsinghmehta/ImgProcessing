function[]=Bquestion8()
    image=imread('barbara.png');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    image=image(1:64,1:64);
    %image=[1 2 ;3 4 ];
    [s1,s2]=size(image);
%     if(2^floor(log2(s1))~=s1||2^floor(log2(s2))~=s2)
%        display('program applicable only for images with dimensions with the power of 2'); 
%        display(size(image));
%        return;
%     end
    for i=1:s1
        F(i,:)=questionB8_sub(image(i,:));
        %display(image(i,:));
    end
    %display(F);
    for j=1:s2
        %display(transpose(image(:,j)));
        F2(:,j)=transpose(questionB8_sub(transpose(F(:,j)))); 
    end
    F_base(1:s1,1:s2)=fft2(image);
    
    figure;
    subplot(1,2,1);imshow(image);title('orignal image');
    subplot(1,2,2);imshow(uint8(abs(ifft2(F2))));title('Reconstructed image from computed FFT');
    
    figure;
    subplot(1,2,1);imagesc(log(1+abs(fftshift(F_base))));title('orignal Fourier Tranform');
    subplot(1,2,2);imagesc(log(1+abs(fftshift(F2))));title('Computed Fourier Transform');
end

function [F_comb]=questionB8_sub(image)
    %image=[1 1 1 1 1 1 1 1];
    num_steps=log2(size(image,2));
%     if(2^floor(log2(num_steps))~=num_steps)
%        display('program only for power of 2');
%         return; 
%     end
    %display(num_steps);
    test=[1 1];
    %fft1d(test,0);
    F_comb=fft1d_g(image);
   % display(F_comb);
end

function[F_comb]=fft1d_g(seq)
    num_entries=size(seq,2);
    F_even(1:num_entries/2)=0;
    F_odd(1:num_entries/2)=0;
    F_comb(1:num_entries)=0;
    seq_even(1:num_entries/2)=0;
    seq_odd(1:num_entries/2)=0;
    
    for i=1:num_entries/2
       seq_even(i)=seq(2*i-1);
       seq_odd(i)=seq(2*i);
    end
    if(num_entries==2)
       F_comb=[seq(1)+seq(2),seq(1)-seq(2)]; 
        return;
    else
       for u=1:num_entries
%            clc; 
%            display(u);
          F_comb(u)=fft1d(seq_even,u-1)+exp(-2*pi*1i*(u-1)/num_entries)*fft1d(seq_odd,u-1); 
       end
    end

end

function[result]=fft1d(seq,u)
    
    num_entries=size(seq,2);
%      display(num_entries);
     if(num_entries==1)
        result=seq;
        
     else
        seq_even(1:num_entries/2)=0;
        seq_odd(1:num_entries/2)=0;
        for i=1:num_entries/2
           seq_even(i)=seq(2*i-1);
           seq_odd(i)=seq(2*i);
        end
%         display(seq_even);
%         display(seq_odd);
        %pause(3);
        result=fft1d(seq_even,u)+exp(-2*pi*1i*u/num_entries)*fft1d(seq_odd,u);
     end
end