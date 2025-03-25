M = {}


function M.get_python_executable()
	local handle = io.popen("pyenv which python 2>/dev/null")
	if not handle then
		return nil
	end

	local result = handle:read("*a")
	handle:close()

	if not result or result == "" then
		return nil
	end

	result = result:gsub("%s+$", "") -- remove trailing newlines/spaces
	return result
end

function M.get_pyenv_env_name()
	local handle = io.popen("pyenv version-name 2>/dev/null")
	if not handle then
		return nil
	end

	local result = handle:read("*a")
	handle:close()

	if not result or result == "" then
		return nil
	end

	result = result:gsub("%s+$", "") -- remove trailing newlines/spaces
	return result
end

return M
