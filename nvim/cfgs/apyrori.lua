-- settings of apyrori.nvim

require("telescope").load_extension("apyrori")

vim.keymap.set("n", "<Leader>i", "<Cmd>Telescope apyrori<CR>")

require("apyrori").setup({
    choose_most_likely = true,

    default_imports = {
        "import numpy as np",
        "import pandas ad pd",
        "import matplotlib.pyplot as plt",
        "import matplotlib.patches as patches",
        "import torch",
        "import torch.nn as nn",
        "import torch.nn.functional as F",
    }
})
