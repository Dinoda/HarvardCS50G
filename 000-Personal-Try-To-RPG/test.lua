t = {}
s = "from=world, to=Lua"
for k, v in string.gmatch(s, "(%w+)=(%w+)") do
	t[k] = v
	print(k .. ':::' .. v)
end
