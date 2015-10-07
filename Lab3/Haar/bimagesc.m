function h = bimagesc(varargin)
%BIMAGESC Scale data and display as image.
%   BIMAGESC(...) is the same as IMAGESC(...) except the axes are omitted
%   and scaled for an image.

imagesc(varargin{:});
axis image;
colormap(gray(256));
axis off;
%set(gca,'Ytick',[]);
%set(gca,'Xtick',[]);
drawnow