function[]=question5()
  %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  im=imread('BirdFish.jpg');
  min_3channel=min(im(:));
  max_3channel=max(im(:));
  fprintf('Maximum value in the image=%d\nMinimum Value in image=%d\n',max_3channel,min_3channel);
  if(size(im,3)==3)
     for k=1:3
        min_value(k)=min(min(im(:,:,k)));
        max_value(k)=max(max(im(:,:,k)));
        fprintf('Minimum value for channel %d=%d Maximum value for channel %d=%d\n',k,min_value(k),k,max_value(k));
     end
  end
  fprintf('Result of whos im command=\n');
  whos im;
  fprintf('plotting results of imagesc for each channel\n');
  k1=0;k2=100;
  if(size(im,3)==3)
     for k=1:3
        figure;imagesc(im(:,:,k),[k1,k2]);
     end
  end
end