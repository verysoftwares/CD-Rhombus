view = {}

function view.loadscreen()
    if not view.allimg then
        view.allimg = {}
        local dirs = lfs.getDirectoryItems('document')
        for i,dir in ipairs(dirs) do
            local imgs = lfs.getDirectoryItems('document/'..dir)
            for j,img in ipairs(imgs) do
                table.insert(view.allimg,'document/'..dir..'/'..img)
            end
        end
    end
    view.imgname = view.allimg[random(#view.allimg)]
    view.img = lg.newImage(view.imgname)
    view.imgname = 'Sommitelma '..string.sub(view.imgname,string.find(view.imgname,'-')+1,#view.imgname-4)
    print(view.imgname)
end

function view.wait()
    if tapped('tab') then 
        if not (press('lshift') or press('rshift')) then
            view.loadscreen()
        else
            view.img = nil; view.imgname = nil
        end
    end
end

function view.showscreen()
    if not view.img then return end
    fg(1,1,1,1)
    lg.draw(view.img,-1,-31)
    fg(0.7,0.4,0.4,1)
    lg.print(view.imgname,SW-lg.getFont():getWidth(view.imgname),SH-lg.getFont():getHeight(view.imgname))
end