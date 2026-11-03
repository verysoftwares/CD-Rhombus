require 'alias'
require 'utility'

system = {update={},draw={}}

-- used to start/finish an every-frame update or draw function
    function system.follow(mode,update_fn,index)
        index = index or #system[mode]+1
        table.insert(system[mode],index,update_fn)
    end

    function system.cease(mode,update_fn)
        for i=#system[mode],1,-1 do
            local v = system[mode][i]
            if v==update_fn then table.remove(system[mode],i) end
        end
    end

    function system.find(mode,update_fn)
        for i,v in ipairs(system[mode]) do
            if v==update_fn then return i end
        end
        return nil
    end

t = 0   -- global time in frames since starting program

asset = {}
asset.maincanvas = lg.newCanvas(SW,SH)

asset.piece1 = lg.newImage('asset/piece1.png')
asset.piece1b = lg.newImage('asset/piece1b.png')
asset.piece2 = lg.newImage('asset/piece2.png')
asset.piece2b = lg.newImage('asset/piece2b.png')
asset.piece3 = lg.newImage('asset/piece3.png')
asset.pieces = {asset.piece1b,asset.piece2b,asset.piece3}

lg.setDefaultFilter('nearest')
lg.setLineWidth(1)

require 'shapes'

system.follow('update',shapes.place)
system.follow('update',shapes.wait)
system.follow('draw',shapes.griddraw)
system.follow('draw',shapes.piecedraw)

function love.update(dt)
    -- global update functions are refreshed every frame,
    -- with LÖVE's deltatime as argument.
        
        for i,update_fn in ipairs(system.update) do
            update_fn(dt)
        end

    if system.pause then return end
        t = t+1
end

function love.draw()
    -- render moving parts of project to main canvas.

        lg.setCanvas(asset.maincanvas)
            if shapes.palette==0 then
                bg(1.0,0.95,0.5,1.0)
            elseif shapes.palette==9 then
                bg(0.96,0.96,0.96,1.0)
            elseif shapes.palette==10 then
                bg(0.91,0.96,0.91,1.0)
            else bg(0.95,0.89,0.72,1.0) end
            --bg(0.25,0.19,0.12,1.0)
            fg(1,1,1,1)
            for i,draw_fn in ipairs(system.draw) do
                draw_fn()
            end

    -- render main canvas to window
    -- ..accounting for fullscreen.

        lg.setCanvas()
            bg(1.0,0.95,0.5,1.0)
            fg(1,1,1,1)
            local fw,fh,fflags = love.window.getMode()
            if not fflags.fullscreen then
                lg.draw(asset.maincanvas,0,0)
            else 
                local sc1 = fw/SW
                local sc2 = fh/SH
                local scf = math.min(sc1,sc2)
                local sox = (fw/2 - SW*scf/2)
                local soy = (fh/2 - SH*scf/2)
                if sc1>sc2 then lg.draw(asset.maincanvas,sox,0,  0,scf,scf)
                else            lg.draw(asset.maincanvas,0,  soy,0,scf,scf)
                end
            end
end

function love.keypressed(key)
    if key=='escape' then
        love.event.quit(0)
    end
    if key=='f11' then
        local fw,fh,fflags = love.window.getMode()
        if fflags.fullscreen then
             love.window.setMode(SW,SH,{fullscreen=false})
        else love.window.setMode(0, 0, {fullscreen=true }) 
        end
    end
end