local M = {}

-- デフォルト設定
M.config = {
    delete_method = "trash", -- "trash", "rm", or "confirm"
}

-- ユーザー設定を反映
function M.setup(user_config)
    if user_config then
        M.config = vim.tbl_deep_extend("force", M.config, user_config)
    end

    -- 起動時に trash-put の存在を確認（必要な場合のみ）
    if
        (M.config.delete_method == "trash" or M.config.delete_method == "confirm")
        and vim.fn.executable("trash-put") == 0
    then
        vim.schedule(function()
            vim.notify("'trash-put' not found! Install it with:\n  pip install --user trash-cli", vim.log.levels.ERROR)
        end)
    end

    -- 自動コマンド設定
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        callback = M.maybe_delete_typo_file,
    })
end

-- ファイル名が怪しければ削除処理（trash/rm/confirm）
function M.maybe_delete_typo_file()
    local filename = vim.fn.expand("%:t")
    local filepath = vim.fn.expand("%:p")
    local pattern = "^[%[%]{}()'\"]$"

    if not (filename:match(pattern) and vim.fn.filereadable(filepath) == 1) then
        return
    end

    if M.config.delete_method == "trash" then
        M._trash(filepath)
    elseif M.config.delete_method == "rm" then
        M._rm(filepath)
    elseif M.config.delete_method == "confirm" then
        local choice = vim.fn.input("Typo file detected: " .. filename .. ". Delete? (y/n): ")
        if choice == "y" then
            if vim.fn.executable("trash-put") == 1 then
                M._trash(filepath)
            else
                M._rm(filepath)
            end
        else
            vim.notify("Skipped deleting: " .. filepath, vim.log.levels.INFO)
        end
    else
        vim.notify("Invalid delete method: " .. M.config.delete_method, vim.log.levels.ERROR)
    end
end

-- 削除処理（ゴミ箱）
function M._trash(path)
    vim.notify("Trashing typo file: " .. path, vim.log.levels.WARN)
    vim.fn.system({ "trash-put", path })
end

-- 削除処理（完全削除）
function M._rm(path)
    vim.notify("Removing typo file: " .. path, vim.log.levels.WARN)
    vim.fn.delete(path)
end

return M
