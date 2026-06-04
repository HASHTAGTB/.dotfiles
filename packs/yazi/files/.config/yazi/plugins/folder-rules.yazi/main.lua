local function setup()
	ps.sub("ind-sort", function(opt)
		local cwd = cx.active.current.cwd
		local by_time = cwd:ends_with("Downloads")
			or cwd:ends_with("Trash/files")
			or cwd:ends_with("Screenshots")
			or cwd:ends_with("dl")
		if by_time then
			opt.by, opt.reverse, opt.dir_first = "mtime", true, false
		else
			opt.by, opt.reverse, opt.dir_first = "natural", false, true
		end
		return opt
	end)
end

return { setup = setup }
