function plotKSVMfig(alpha, datatrain, xmin, xmax, ymin, ymax, label, kernel, argsup)

figure;
hold on;

[x_b,y_b]= meshgrid(xmin:(xmax-xmin)/100:xmax,ymin:(ymax-ymin)/100:ymax);
z_b= zeros(size(x_b));
z_b(:) = Kdecision(alpha, datatrain, [x_b(:)';y_b(:)'], label,kernel, argsup);
sp = pcolor(x_b,y_b,z_b);
load red_black_colmap;
colormap(red_black);
shading flat;
set(gca,'XLim',[xmin xmax],'YLim',[ymin ymax]);
plot(datatrain(1,:),datatrain(2,:), 'b+');
contour(x_b,y_b,z_b,[-1 0 1], 'b-');
end