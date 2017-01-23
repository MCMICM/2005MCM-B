function h = show_plaza(plaza, h, n)
%
% show_plaza  To show the plaza matrix as a image
% 
% USAGE: h = show_plaza(plaza, h, n)
%        plaza = plaza matrix
%                1 = car, 0 = empty, -1 = forbid, -3 = empty&booth
%        h = handle of the graphics
%        n = pause time
%
% zhou lvwen: zhou.lv.wen@gmail.com

[L, W] = size(plaza); % get its dimensions

% mark & color:  car;       empty;      forbid;       booth;
mark  = [          1;           0;          -1;          -3];
color = [0.0 0.0 1.0; 1.0 1.0 1.0; 0.5 0.5 0.5; 0.0 1.0 0.0];
rgb = mat2rgb(plaza, mark, color);

if ishandle(h)
    set(h,'CData',rgb)
    pause(n)
else
    figure('position',[20,50,200,700])
    h = imagesc(rgb);
    hold on
    % draw the grid
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k')
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k')
    axis image
    set(gca, 'xtick', [], 'ytick', []);
    pause(n)
end

% -------------------------------------------------------------------------

function rgb = mat2rgb(mat, mark, color)
[R, G, B] = deal(zeros(size(mat)));
for i = 1:length(mark)
    R(mat==mark(i)) = color(i,1);
    G(mat==mark(i)) = color(i,2);
    B(mat==mark(i)) = color(i,3);
end
rgb = cat(3, R, G, B);

% -------------------------------------------------------------------------

function hi = imagesc2(mat, mark, color)
x = 0.5*[-1  1 1 -1];
y = 0.5*[-1 -1 1  1];
for i = 1:length(mark);
   if all(color(i,:)==1); continue; end
   [J,I] = find(mat==mark(i));
   xi = bsxfun(@plus, I, x)';
   yi = bsxfun(@plus, J, y)';
   hi = fill(xi,yi, color(i,:));
end
