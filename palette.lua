palette = {i=1,
    [0]  = function(info) return 1,1,1,1 end,
    [1]  = function(info) return 0.7+0.1,0.4+0.1,0.4+0.1,1 end,
    [2]  = function(info) return (0.7+0.1+info.piece[1]*0.061)%1,(0.4+0.1+info.piece[2]*0.061)%1,0.4+0.1,1 end,
    [3]  = function(info) return (0.7+0.1+info.i*0.061)%1,0.4+0.1,(0.4+0.1+info.i*0.061)%1,1 end,
    [4]  = function(info) return (0.7+0.1+(info.i*0.14+info.t*0.14)*0.061)%1,0.4+0.1,0.4+0.1,1 end,
    [5]  = function(info) return 0.7+0.1-info.piece.img*0.1,0.4+0.1+info.piece.img*0.2,0.4+0.1-info.piece.img*0.06,1 end,
    [6]  = function(info) return 0.4+0.1,0.7+0.1,0.7+0.1,1 end,
    [7]  = function(info) return 0.7+0.1,0.4+0.1,0.7+0.1,1 end,
    [8]  = function(info) return 0.85+0.1,0.75+0.1,0.35+0.1,1 end,
    [9]  = function(info) 
        if info.piece.img==1 then return 1,1,1,1 end
        if info.piece.img==2 then return 1,0.5,0.6,1 end
        if info.piece.img==3 then return 0.6,1,0.5,1 end 
    end,
    [10] = function(info) 
        if info.piece.img==2 then return 1,1,1,1 end
        if info.piece.img==3 then return 1,0.5,0.6,1 end
        if info.piece.img==1 then return 0.6,1,0.5,1 end
    end,
    [11] = function(info)
        if info.piece.img==3 then return 1,1,1,1 end
        if info.piece.img==1 then return 1,0.5,0.6,1 end
        if info.piece.img==2 then return 0.6+0.12,1-0.12,0.5+0.12,1 end
    end,
    [12]  = function(info) return 0.85,1,0.75,1 end,
    sel = function() return 0.3,0.9,1,1 end,--0.6,0.9,0.6,1
    grid = function() 
        if palette.i==0 then return 0.85,0.85,0.75,1
        elseif palette.i==9 then return 0.89-0.08,0.92-0.08,0.89-0.08,1
        elseif palette.i==10 then return 0.96-0.06,0.81-0.06,0.81-0.06,1
        elseif palette.i==12 then return 0.91-0.04*2,0.91-0.04*2,0.96-0.11*2,1
        end
        return 0.8,0.8,0.7,1
    end,
    bg = function() 
        if palette.i==0 then return 1.0,0.95,0.5,1.0
        elseif palette.i==9 then return 0.96,0.96,0.96,1.0
        elseif palette.i==10 then return 0.91,0.96,0.91,1.0
        elseif palette.i==12 then return 0.91,0.91,0.96,1.0
        end
        return 0.95,0.89,0.72,1.0
    end,
    hover = function(info)
        if palette.i==0 or
           (palette.i==9  and info.piece.img==1) or
           (palette.i==10 and info.piece.img==2) or
           (palette.i==11 and info.piece.img==3) then
            return 0.8,0.8,1,1
        end
        return 1,1,1,1
    end,
}

function palette.cycle(dt)
    if tapped('p') then
        palette.i = palette.i+1
        if palette.i == 12 then
            asset.pieces[1] = asset.piece1
            asset.pieces[2] = asset.piece2
        elseif palette.i > #palette then 
            palette.i = 0
        elseif palette.i == 1 then
            asset.pieces[1] = asset.piece1b
            asset.pieces[2] = asset.piece2b
        end
    end
end