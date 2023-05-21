local black=tocolor(0,0,0,255)

function toboolean(bool)
	if bool=='true' then
		return true
	end
	if bool=='false' then
		return false
	end
	return nil
end

function math.clip(min,val,max)
	return math.max(min,math.min(max,val))
end

addCommandHandler('getInfo',function()
	local info=dxGetStatus()
	for k,v in pairs(info) do
		outputConsole(k..' : '..tostring(v))
	end
end)

function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY,clip,wordbreak,postgui)
	if alignX then
		if alignX == 'center' then
			local w = dxGetTextWidth(str:gsub('#%x%x%x%x%x%x',''), scale, font)
			ax = ax + (bx-ax)/2 - w/2
		elseif alignX == 'right' then
			local w = dxGetTextWidth(str:gsub('#%x%x%x%x%x%x',''), scale, font)
			ax = bx - w
		end
	end
	if alignY then
		if alignY == 'center' then
			local h = dxGetFontHeight(scale, font)
			ay = ay + (by-ay)/2 - h/2
		elseif alignY == 'bottom' then
			local h = dxGetFontHeight(scale, font)
			ay = by - h
		end
	end
	local pat = '(.-)#(%x%x%x%x%x%x)'
	local s, e, cap, col = str:find(pat, 1)
	local last = 1
	while s do
		if cap == '' and col then color = tocolor(tonumber('0x'..col:sub(1, 2)), tonumber('0x'..col:sub(3, 4)), tonumber('0x'..col:sub(5, 6)), 255) end
		if s ~= 1 or cap ~= '' then
			local w = dxGetTextWidth(cap, scale, font)
			dxDrawText(cap, ax, ay, ax + w, by, color, scale, font,'left','top',true,wordbreak,postgui)
			ax = ax + w
			color = tocolor(tonumber('0x'..col:sub(1, 2)), tonumber('0x'..col:sub(3, 4)), tonumber('0x'..col:sub(5, 6)), 255)
		end
		last = e + 1
		s, e, cap, col = str:find(pat, last)
	end
	if last <= #str then
		cap = str:sub(last)
		local w = dxGetTextWidth(cap, scale, font )
		dxDrawText(cap, ax, ay, ax + w, by, color, scale, font,'left','top')
	end
end

function dxDrawTextBordered(text,x1,y1,x2,y2,color,thickness,scale,font,alignX,alignY,textclip,wordbreak,postgui)
	for w=-thickness,thickness,thickness do
		for h=-thickness,thickness,thickness do
			if not(w==0 and h==0) then
				dxDrawText(text,x1+w,y1+h,x2+w,y2+h,black,scale,font,alignX,alignY,textclip,wordbreak,postgui)
			end
		end
	end
	dxDrawText(text,x1,y1,x2,y2,color,scale,font,alignX,alignY,textclip,wordbreak,postgui)
end

function getPointFromDistanceRotation(x,y,dist,angle)
	local a=math.rad(90-angle)
	local dx=math.cos(a)*dist
	local dy=math.sin(a)*dist
	return x+dx,y+dy
end

function getVectorRotation(px,py,lx,ly)
	local rotz=6.2831853071796-math.atan2(lx-px,ly-py)%6.2831853071796
	return -rotz
end

function doesCollide(x1,y1,v1,h1,x2,y2,v2,h2)
	local horizontal=(x1<x2)~=(x1<x2+v2) or (x1+v1<x2)~=(x1+v1<x2+v2) or (x1<x2)~=(x1+v1<x2) or (x1<x2+v2)~=(x1+v1<x2+v2)
	local vertical=(y1<y2)~=(y1<y2+h2) or (y1+h1<y2)~=(y1+h1<y2+h2) or (y1<y2)~=(y1+h1<y2) or (y1<y2+h2)~=(y1+h1<y2+h2)
	return (horizontal and vertical)
end

function isRingInRing(x1,y1,r1,x2,y2,r2)
	return r1+r2>=getDistanceBetweenPoints2D(x1,y1,x2,y2)
end

function table.copy(tab)
	local ret = {}
	for key, value in pairs(tab) do
		if (type(value) == 'table') then ret[key] = table.copy(value)
		else ret[key] = value end
	end
	return ret
end

function fromcolor( color )
	local colorCode = string.format( "%x", color )
	local a = string.sub( colorCode, 1, 2 ) or "FF"
	local r = string.sub( colorCode, 3, 4 ) or "FF"
	local g = string.sub( colorCode, 5, 6 ) or "FF"
	local b = string.sub( colorCode, 7, 8 ) or "FF"
	a = tonumber( "0x" .. a )
	r = tonumber( "0x" .. r )
	g = tonumber( "0x" .. g )
	b = tonumber( "0x" .. b )
	return r, g, b, a
end
