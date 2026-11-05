view = {}

function view.loadscreen()
    if not view.allimg then
        view.allimg = {}
        local content = lfs.getDirectoryItems('document')
        for i,item in ipairs(content) do
            if lfs.getInfo('document/'..item).type=='directory' then
                local imgs = lfs.getDirectoryItems('document/'..item)
                for j,img in ipairs(imgs) do
                    table.insert(view.allimg,'document/'..item..'/'..img)
                end
            else
                table.insert(view.allimg,'document/'..item)
            end
        end
    end
    
    view.imgname = view.allimg[random(#view.allimg)]
    view.img = lg.newImage(view.imgname)
    
    local sep = string.find(view.imgname,'-')
    if sep then view.imgname = 'Sommitelma '..string.sub(view.imgname,sep+1,#view.imgname-4)
    else view.imgname = 'Sommitelma ??'
    end
    print(view.imgname)
end

function view.wait()
    if tapped('tab') then 
        if not (press('lshift') or press('rshift')) then
            view.loadscreen()
            system.follow('draw',view.showscreen)
        else
            system.cease('draw',view.showscreen)
        end
    end
end

function view.showscreen()
    fg(1,1,1,1)
    lg.draw(view.img,-1,-31)
    fg(0.7,0.4,0.4,1)
    lg.print(view.imgname,SW-lg.getFont():getWidth(view.imgname),SH-lg.getFont():getHeight(view.imgname))
end