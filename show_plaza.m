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

if nargin==0; plaza = create_plaza(8, 4, 29); h = NaN; n = 0; end

% mark & color:  car;       empty;      forbid;       booth;
mark  = [          1;           0;          -1;          -3];
color = [0.0 0.0 1.0; 1.0 1.0 1.0; 0.5 0.5 0.5; 0.0 1.0 0.0];
rgb = mat2rgb(plaza, mark, color);

if ishandle(h)
    set(h,'CData',rgb)
else
    figure('position',[20,50,200,700]);
    h = imagesc(rgb); title(['B = ',num2str(size(plaza,2)-2)]);
    hold on; axis image; set(gca, 'xtick', [], 'ytick', []);
    % draw the grid
    [L, W] = size(plaza);
    plot([0:W;0:W]+0.5, [0;L]+0.5,'k', [0;W]+0.5,[0:L;0:L]+0.5,'k')
end
pause(n)

% -------------------------------------------------------------------------

function rgb = mat2rgb(mat, mark, color)
[R, G, B] = deal(zeros(size(mat)));
for i = 1:length(mark)
    R(mat==mark(i)) = color(i,1);
    G(mat==mark(i)) = color(i,2);
    B(mat==mark(i)) = color(i,3);
end
rgb = cat(3, R, G, B);
