function sc_plotallclusters(features,mua);

psize=0.65;
%plot(mua.ts_spike+1.5,mua.waveforms./1000);

xpos=[0 0 0 1 1 1 2 2 2];
ypos=[1 2 3 1 2 3 1 2 3];


for i=1:features.Nclusters
    xo=(xpos(i)*(psize+.01))+.05;
    yo=-(ypos(i)*(psize+.01))+1;
    
    %im=-sqrt(min(features.clusterimages(:,:,i),70));
    im=-((features.clusterimages(:,:,i)./max(max(features.clusterimages(:,:,i))) ).^(.3));
    
    imagesc( linspace(1,1+psize,features.imagesize)+xo , linspace(0,psize,features.imagesize)+yo , im );
    
    text(xo+1.01,yo+0.02,num2str(i),'color',[0 0 0]);
    
    plot(xo+1.06,yo+0.03,features.clusterfstrs{i},'MarkerSize',22,'color',features.colors(i,:));
    
    if i==1
        text(xo+1.1 ,yo+0.02,['N: ',num2str(sum(features.clusters==i)),' (MUA/null cluster)'],'color',[0 0 0]);
    else
        text(xo+1.1 ,yo+0.02,['N: ',num2str(sum(features.clusters==i)),' ',features.labelcategories{features.clusterlabels(i)}],'color',[0 0 0]);
    end;
    
    if i>1
        plot( [1 1.1]+xo , [psize-0.1 psize]+yo,'k'); % diagonal line
        text(xo+1.01,yo+psize-0.02,'tag');
    end;
    
    c=features.colors(i,:);
    plot( [1 1]+xo , [0 psize]+yo,'k','color',c);
    plot( [1+psize 1+psize]+xo , [0 psize]+yo,'k','color',c);
    plot( [1 1+psize]+xo , [0 0]+yo,'k','color',c);
    plot( [1 1+psize]+xo , [psize psize]+yo,'k','color',c);
    
    
    if features.highlight>0
        
        
        %npoints=numel(mua.ts_spike); % crashes with tetrode data
        npoints=size(mua.waveforms,2);
        
        xa=  (linspace(0,psize,npoints));
        ya=  ( mua.waveforms(features.highlight,:)) *features.waveformscale .*psize;
        
        
        if features.plotgroup==1 % display number of wveforms
            for i=1:10
                yb=( mua.waveforms(features.highlight_multiple(i),:)) *features.waveformscale .*psize;
                plot(xa+xo+1,yb+yo+(psize/2),'k--','color',[.1 .1 .1]);
            end;
        end;
        plot(xa+xo+1,ya+yo+(psize/2),'color',features.colors( features.clusters(features.highlight) ,:),'LineWidth',2);
        
        
    end;
end;

colormap gray;
